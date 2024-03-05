//
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
//
// import '../../data/models/Requests/AuthenticateRequest.dart';
// import '../../data/models/Responses/AuthenticateResponse.dart';
// import '../../data/service/AuthenticationService.dart';
// import '../provider/LoginCredentialsProvider.dart';
// import '../provider/TokenProvider.dart';
//
// class GlobalRefreshToken {
//   static bool checkTokenValidity(BuildContext context) {
//     DateTime expiryDate = DateTime.parse(context.read<TokenProvider>().tokenSample.expiryDate);
//     DateTime newExpiryDate = expiryDate.subtract(Duration(seconds: 5));
//     if (DateTime.now().toUtc().isBefore(newExpiryDate)) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   // static Future<bool> hasRenewedJwtToken(BuildContext context) async {
//   //   AuthenticationService authenticationService = AuthenticationService();
//   //   AuthenticateResponse authenticateResponse = await authenticationService.authenticateLogin(AuthenticateLoginRequest(
//   //       UserName: context.read<LoginCredentialsProvider>().authenticateLoginRequest.UserName,
//   //       Password: context.read<LoginCredentialsProvider>().authenticateLoginRequest.Password));
//   //   if (authenticateResponse != null) {
//   //     if (authenticateResponse.isSuccess) {
//   //       context.read<TokenProvider>().setToken(authenticateResponse.token);
//   //       return true;
//   //     } else {
//   //       return false;
//   //     }
//   //   } else {
//   //     return false;
//   //   }
//   // }
//
//   // static Future<bool> hasValidTokenToSend(BuildContext context) async {
//   //   if (checkTokenValidity(context)) {
//   //     return true;
//   //   }
//   //
//   //   AuthenticateResponse authenticateResponse = await authenticationService.authenticateRefresh(
//   //       AuthenticateRefreshRequest(
//   //           jwtToken: context.read<TokenProvider>().tokenSample.jwtToken,
//   //           refreshToken: context.read<TokenProvider>().tokenSample.refreshToken));
//   //   if (authenticateResponse != null) {
//   //     if (authenticateResponse.isSuccess) {
//   //       if (authenticateResponse.token.isSuccess) {
//   //         context.read<TokenProvider>().setToken(authenticateResponse.token);
//   //         return true;
//   //       }
//   //       return hasRenewedJwtToken(context);
//   //     }
//   //     return hasRenewedJwtToken(context);
//   //   }
//   //   return hasRenewedJwtToken(context);
//   // }
// }
