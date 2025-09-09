import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra_pix/features/profile/domain/repos/profile_repo.dart';
import 'package:mitra_pix/features/profile/presentation/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profielRepo;

  ProfileCubit({
    required this.profielRepo,
  }) : super(ProfileInitial());

  // fetch user profile using repo

  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());

      final user = await profielRepo.fetchUserProfile(uid);

      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("User not found!"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // update bio and or profile picture

  Future<void> updateProfile({
    required String uid,
    String? newBio,
  }) async {
    emit(ProfileLoading());

    try {
      // fetch current profile first

      final currentUser = await profielRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError("Failed to fetch user for profile update"));
        return;
      }

      // profile picture udpate

      // update new profile

      final updatedProfile =
          currentUser.copyWith(newBio: newBio ?? currentUser.bio);

      // update in repo
      await profielRepo.updateProfile(updatedProfile);

      // refetch the updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }
}
