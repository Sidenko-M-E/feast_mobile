// import 'package:feast_mobile_email/features/otp_page/ui/otp_page_state_manager.dart';
// import 'package:feast_mobile_email/features/signin_page/ui/signin_page_state_manager.dart';
// import 'package:feast_mobile_email/features/signup_page/bloc/signup_bloc.dart';
// import 'package:feast_mobile_email/features/signup_page/ui/signup_page_layout.dart';
// import 'package:feast_mobile_email/features/signup_page/widgets/signup_alert_dialog.dart';
// import 'package:feast_mobile_email/routes/routes.dart';
// import 'package:feast_mobile_email/services/http_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => SignupBloc(
//             httpService: RepositoryProvider.of<HttpService>(context)),
//         child: BlocConsumer<SignupBloc, SignupState>(
//           listenWhen: (previous, current) => (current is SignupStateToListen),
//           listener: (context, state) {
//             switch (state.runtimeType) {
//               case SignupAlertState:
//                 showAdaptiveDialog(
//                     context: context,
//                     builder: (BuildContext context) =>
//                         SignupAlertDialog(state: state as SignupAlertState));
//               case SignupStateGoToSignin:
//                 goRouter.go('/profile/signin');
//               case SignupStateGoToOTP:
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => OTPPage(user: (state as SignupStateGoToOTP).user)));
//             }
//           },
//           buildWhen: (previous, current) => (current is SignupStateToRebuild),
//           builder: (context, state) {
//             switch (state.runtimeType) {
//               case SignupStateLoading:
//                 return AbsorbPointer(
//                   child: Stack(
//                     children: [
//                       SignupPageLayout(widgetState: state as SignupStateLoading),
//                       Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         color: Colors.grey[200]!.withOpacity(0.6),
//                       ),
//                       Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.blue,
//                           strokeWidth: 5.0,
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               case SignupStateToRebuild:
//                 return SignupPageLayout(widgetState: state as SignupStateToRebuild);
//               default:
//                 throw Exception('WrongState');
//             }
//           },
//         ));
//   }
// }
