import 'package:feast_mobile_email/features/auth/signin_page/ui/signin_page_layout.dart';
import 'package:feast_mobile_email/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/auth_alert_dialog.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthVM>();
    return authVM.loading
        ? Stack(
            children: [
              AbsorbPointer(child: SigninPageLayout()),
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
        : authVM.errorMessage == null
            ? SigninPageLayout()
            : Stack(
                children: [
                  AbsorbPointer(child: SigninPageLayout()),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey[200]!.withOpacity(0.6),
                  ),
                  AuthAlertDialog(
                    title: authVM.errorMessage!.title,
                    description: authVM.errorMessage!.description,
                    onSubmit: () {
                      authVM.setErrorMessage(null);
                    },
                  )
                ],
              );
  }
}
