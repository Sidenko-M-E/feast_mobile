import 'package:feast_mobile_email/features/otp_page/bloc/otp_bloc.dart';
import 'package:feast_mobile_email/features/otp_page/ui/otp_page_layout.dart';
import 'package:feast_mobile_email/features/otp_page/widgets/alert_dialog.dart';
import 'package:feast_mobile_email/features/successfull_signup_page/successfull_signup_page.dart';
import 'package:feast_mobile_email/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, required this.user});
  final User user;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpBloc>(
        create: (context) =>
            OtpBloc(user: widget.user)..add(OtpRequestNewCode()),
        child: BlocConsumer<OtpBloc, OtpState>(
          listenWhen: (previous, current) => current is OtpStateToListen,
          listener: (context, state) {
            switch (state.runtimeType) {
              case OtpStateGoBack:
                Navigator.of(context).pop();
                break;
              case OtpStateSignUpSuccess:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SuccessfullSignUpPage(user: widget.user)));
                break;
              case OtpStateAlert:
                showAdaptiveDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        OtpAlertDialog(state: state as OtpStateAlert));
                break;
              case OtpStateEmailOccupied:
                showAdaptiveDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        OtpAlertDialog(state: state as OtpStateAlert));
                Navigator.of(context).pop();
                break;
            }
          },
          buildWhen: (previous, current) => current is OtpStateToRebuild,
          builder: (context, state) {
            switch (state.runtimeType) {
              case OtpStateLoading:
                return AbsorbPointer(
                  child: Stack(
                    children: [
                      OtpPageLayout(
                        state: state as OtpStateToRebuild,
                        user: widget.user,
                      ),
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
                  ),
                );
              case OtpStateToRebuild:
                return OtpPageLayout(
                  state: state as OtpStateToRebuild,
                  user: widget.user,
                );
              default:
                throw Exception('Wrong state');
            }
          },
        ));
  }
}
