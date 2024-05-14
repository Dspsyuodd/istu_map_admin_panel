import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog(
      {Key? key, required this.message, required this.stackTrace})
      : super(key: key);
  final String message;
  final String stackTrace;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("An unexpected error occurred"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Gap(20),
          Container(
            width: 1000,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade400
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: SelectableText(stackTrace),
              ),
            ),
          )
        ],
      ),
    );
  }
}
