import 'package:feast_mobile/features/auth/otp_page/ui/otp_page_layout.dart';
import 'package:feast_mobile/features/auth/widgets/auth_alert_dialog.dart';
import 'package:feast_mobile/view_models/otp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    final otpVM = context.watch<OtpVM>();
    return otpVM.loading
        ? Stack(
            children: [
              AbsorbPointer(child: OtpPageLayout()),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[200]!.withOpacity(0.6),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 5.0,
                ),
              )
            ],
          )
        : otpVM.errorMessage == null
            ? OtpPageLayout()
            : Stack(children: [
                AbsorbPointer(child: OTPPage()),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey[200]!.withOpacity(0.6),
                ),
                AuthAlertDialog(
                  title: otpVM.errorMessage!.title,
                  description: otpVM.errorMessage!.description,
                  onSubmit: () {
                    otpVM.setErrorMessage(null);
                  },
                ),
              ]);
  }
}
