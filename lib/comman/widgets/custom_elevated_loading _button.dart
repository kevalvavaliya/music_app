import 'package:flutter/material.dart';

class CustomElevatedLoadingButton extends StatefulWidget {
  const CustomElevatedLoadingButton(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final Function onPressed;

  @override
  State<CustomElevatedLoadingButton> createState() =>
      _CustomElevatedLoadingButtonState();
}

class _CustomElevatedLoadingButtonState
    extends State<CustomElevatedLoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isLoading
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                await widget.onPressed();
                if (context.mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(widget.label));
  }
}
