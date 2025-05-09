import 'package:flutter/material.dart';
import 'package:flutter_web_app/features/weather/domain/exceptions/location_exceptions.dart';

class LocationErrorsDialog extends StatelessWidget {
  final LocationException exception;
  const LocationErrorsDialog({
    super.key,
    required this.exception,
  });

  static Future<void> show({
    required BuildContext context,
    required LocationException exception,
  }) async {
    await showAdaptiveDialog(
      context: context,
      builder: (_) => LocationErrorsDialog(
        exception: exception,
      ),
    );
  }

  String get title {
    return switch (exception) {
      GpsDisabledException() => 'GPS is disabled.',
      LocationPermissionDeniedException() => 'Permission was denied.',
      LocationPermitionDenieForeverException() =>
        'Permission was denied forever!',
      _ => 'Ops, something went wrong!',
    };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(title),
      content: Text(
        switch (exception) {
          GpsDisabledException() => 'Try to enable it and try again.',
          LocationPermissionDeniedException() =>
            'Please, try again and accept it.',
          LocationPermitionDenieForeverException() =>
            'Please, go to your settings and authorize the location permission',
          _ =>
            'An error occurred while loading your location. If the error persists, wait a few minutes and try again',
        },
      ),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
