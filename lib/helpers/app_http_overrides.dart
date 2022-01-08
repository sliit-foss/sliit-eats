import 'dart:io';

class AppHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? securityContext) {
    return super.createHttpClient(securityContext)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
