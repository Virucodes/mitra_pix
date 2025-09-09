/*
   Auth Repository - outlines the possible auth operations for the app.
*/

import 'package:mitra_pix/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailAndPassword(String email, String password);
  Future<AppUser?> registerWithEmailAndPassword(String name, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
