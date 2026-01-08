import 'package:local_auth/local_auth.dart';

class BoimetricHelper {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> isDeviceSupported()
  async{
    return await auth.isDeviceSupported();
  }

  static Future<List<BiometricType>> getAvailableBiometric() async{
    return await auth.getAvailableBiometrics();
  }

  static Future<bool> authunticate()
  async{
    return await auth.authenticate(
      localizedReason: 'Please authenticate to start browsing',
      biometricOnly: true,
    );
  }
}