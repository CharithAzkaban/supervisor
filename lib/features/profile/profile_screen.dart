import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:performer/models/user.dart';
import 'package:performer/providers/auth_provider.dart';
import 'package:performer/utils/actions.dart';
import 'package:performer/utils/consts.dart';
import 'package:performer/utils/methods.dart';
import 'package:performer/widgets/back.dart';
import 'package:performer/widgets/gap.dart';
import 'package:performer/widgets/primary_button.dart';
import 'package:performer/widgets/primary_icon_button.dart';
import 'package:performer/widgets/primary_text.dart';
import 'package:performer/widgets/primary_tff.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  late final AuthProvider _authProvider;
  late final User? _user;
  final _imageListener = ValueNotifier<XFile?>(null);
  final _dobListener = ValueNotifier<DateTime?>(null);

  @override
  void initState() {
    super.initState();
    _authProvider = provider<AuthProvider>(context);
    _user = _authProvider.user;
    _fnameController.text = _user?.userFirstName ?? '';
    _lnameController.text = _user?.userLastName ?? '';
    _mobileController.text = _user?.userMobile ?? '';
    _emailController.text = _user?.userEmail ?? '';
    _addressController.text = _user?.userAddress ?? '';
    _dobListener.value = _user?.userBirthdate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          leading: const Back(iconColor: white),
          title: const PrimaryText(
            'Profile',
            color: white,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 20.0,
          ),
          child: PrimaryButton(
            waitingLabel: 'Processing...',
            onPressed: () => _authProvider.editProfile(
              context,
              selectedImage: _imageListener.value,
              birthdate: _dobListener.value,
              fname: textOrEmpty(_fnameController.text),
              lname: textOrEmpty(_lnameController.text),
              mobile: textOrEmpty(_mobileController.text),
              email: textOrEmpty(_emailController.text),
              address: textOrEmpty(_addressController.text),
            ),
            label: 'EDIT PROFILE',
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _imageListener,
                      builder: (context, xfile, _) => Stack(
                        children: [
                          netImage(
                            _user?.userImage,
                            width: 150,
                            height: 150,
                            radius: 500.0,
                          ),
                          if (notNull(xfile))
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(500.0),
                              ),
                            ),
                          if (notNull(xfile))
                            fileImage(
                              xfile!,
                              width: 150,
                              height: 150,
                              radius: 500.0,
                            ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: PrimaryIconButton(
                              onPressed: () => ImagePicker()
                                  .pickImage(source: ImageSource.gallery)
                                  .then((imageFile) {
                                if (notNull(imageFile)) {
                                  _imageListener.value = imageFile;
                                }
                              }),
                              fill: true,
                              icon: Icon(
                                Icons.photo,
                                color: primary,
                              ),
                              backgroundColor: primary,
                            ),
                          ),
                          if (notNull(xfile))
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              child: PrimaryIconButton(
                                onPressed: () => _imageListener.value = null,
                                icon: Icon(
                                  Icons.delete,
                                  color: primary,
                                ),
                                fill: true,
                                backgroundColor: error,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Gap(vGap: 30.0),
                    PrimaryTFF(
                      controller: _fnameController,
                      labelText: 'First Name',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'First name cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryTFF(
                      controller: _lnameController,
                      labelText: 'Last Name',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Last name cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryTFF(
                      keyboardType: TextInputType.phone,
                      controller: _mobileController,
                      labelText: 'Mobile',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Mobile cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryTFF(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      labelText: 'Email',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Email cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    const Gap(vGap: 10.0),
                    ValueListenableBuilder(
                      valueListenable: _dobListener,
                      builder: (context, dob, _) => PrimaryButton(
                        width: inf,
                        onPressed: () => showDatePicker(
                          context: context,
                          initialDate: dob,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((value) => _dobListener.value = value),
                        label: dob != null
                            ? date(
                                dob,
                                format: 'dd MMM yyyy',
                              )
                            : 'Birth Date',
                        outlined: true,
                      ),
                    ),
                    const Gap(vGap: 10.0),
                    PrimaryTFF(
                      controller: _addressController,
                      labelText: 'Address',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
