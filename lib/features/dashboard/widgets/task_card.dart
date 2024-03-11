import 'package:flutter/material.dart';
import 'package:supervisor/utils/attribute.dart';
import 'package:supervisor/utils/consts.dart';
import 'package:supervisor/widgets/primary_text.dart';

class TaskCard extends StatelessWidget {
  final String label;
  final Color color;
  final int tasks;
  const TaskCard({
    super.key,
    required this.label,
    required this.color,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: inf,
      height: 150.0,
      child: InkWell(
        onTap: () {},
        child: Card(
          color: color,
          shape: rrBorder(10.0),
          child: Stack(
            children: [
              Positioned(
                right: -100.0,
                bottom: -100.0,
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                top: -200.0,
                right: -50.0,
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white.withOpacity(0.2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        PrimaryText(
                          label,
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        const Expanded(
                          child: Icon(
                            Icons.assignment,
                            size: 80.0,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryText(
                          '$tasks',
                          color: white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                        const PrimaryText(
                          'TASKS',
                          color: white,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
