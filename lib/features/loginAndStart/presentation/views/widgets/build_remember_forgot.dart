import 'package:flutter/material.dart';

class BuildRememberForgot extends StatelessWidget {
  const BuildRememberForgot({
    super.key,
  });
  final bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {
                value = !value!;
              },
            ),
            const Text(
              'Remember me',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'I forgot my password',
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}
