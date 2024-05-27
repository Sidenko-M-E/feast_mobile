import 'package:feast_mobile_email/features/signin_page/bloc/signin_bloc.dart';
import 'package:feast_mobile_email/features/signin_page/ui/signin_page_layout.dart';
import 'package:feast_mobile_email/features/signup_page/ui/signup_page_state_manager.dart';
import 'package:feast_mobile_email/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/signin_alert_dialog.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SigninBloc(
            httpService: RepositoryProvider.of<HttpService>(context)),
        child: BlocConsumer<SigninBloc, SigninState>(
          listenWhen: (previous, current) => (current is SigninStateToListen),
          listener: (context, state) {
            switch (state.runtimeType) {
              case SigninStateAlert:
                showAdaptiveDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        SigninAlertDialog(state: state as SigninStateAlert));
              case SigninStateGoToSignup:
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpPage()));
            }
          },
          buildWhen: (previous, current) => (current is SigninStateToRebuild),
          builder: (context, state) {
            switch (state.runtimeType) {
              case SigninStateLoading:
                return AbsorbPointer(
                  child: Stack(
                    children: [
                      SigninPageLayout(state: state as SigninStateToRebuild),
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
              case SigninStateToRebuild:
                return SigninPageLayout(state: state as SigninStateToRebuild);
              default:
                throw Exception('WrongState');
            }
          },
        ));
  }
}
