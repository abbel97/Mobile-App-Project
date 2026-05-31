import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure.dart';
import '../../data/repositories/professional_repository_impl.dart';
import '../../domain/entities/professional_entity.dart';

class ProfessionalState {
  final List<ProfessionalEntity> professionals;
  final ProfessionalEntity?      myProfile;
  final bool    isLoading;
  final String? error;
  final bool    isSuccess;

  const ProfessionalState({
    this.professionals = const [],
    this.myProfile,
    this.isLoading  = false,
    this.error,
    this.isSuccess  = false,
  });

  

  ProfessionalState copyWith({
    List<ProfessionalEntity>? professionals,
    ProfessionalEntity?       myProfile,
    bool?    isLoading,
    String?  error,
    bool?    isSuccess,
    bool clearError      = false,
    bool clearSuccess    = false,
    bool clearMyProfile  = false,
  }) =>
      ProfessionalState(
        professionals: professionals ?? this.professionals,
        myProfile:     clearMyProfile ? null : myProfile ?? this.myProfile,
        isLoading:     isLoading  ?? this.isLoading,
        error:         clearError   ? null  : error     ?? this.error,
        isSuccess:     clearSuccess ? false : isSuccess ?? this.isSuccess,
      );
}

class ProfessionalNotifier extends StateNotifier<ProfessionalState> {
  final ProfessionalRepositoryImpl _repo;

  ProfessionalNotifier(this._repo) : super(const ProfessionalState()) {
    loadProfessionals();
  }

  Future<void> loadProfessionals() async {
    state = state.copyWith(isLoading: true, clearError: true, professionals: const []);
    try {
      final list = await _repo.getProfessionals();
      state = state.copyWith(professionals: list, isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to load professionals');
    }
  }

  Future<void> refreshProfessionals() async {
    state = state.copyWith(isLoading: true, clearError: true, professionals: const []);
    try {
      final list = await _repo.refreshProfessionals();
      state = state.copyWith(professionals: list, isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to refresh');
    }
  }

  Future<void> loadMyProfile() async {
    state = state.copyWith(isLoading: true, clearError: true, clearMyProfile: true);
    try {
      final profile = await _repo.getMyProfile();
      state = state.copyWith(myProfile: profile, isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to load profile');
    }
  }

  Future<void> updateProfessional({
    required String id,
    String? name, String? profession, String? bio,
    String? location, int? experienceYears,
    double? serviceRate, String? educationLevel,
    String? skills,
    String? photoBase64,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);
    try {
      final updated = await _repo.updateProfessional(
        id: id, name: name, profession: profession,
        bio: bio, location: location,
        experienceYears: experienceYears,
        serviceRate: serviceRate, educationLevel: educationLevel,
        skills: skills, photoBase64: photoBase64,
      );
      state = state.copyWith(
        professionals: state.professionals
            .map((p) => p.id == updated.id ? updated : p)
            .toList(),
        myProfile:  updated,
        isLoading:  false,
        isSuccess:  true,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to update profile');
    }
  }

  Future<void> deleteProfessional(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.deleteProfessional(id);
      state = state.copyWith(
        professionals: state.professionals.where((p) => p.id != id).toList(),
        isLoading: false,
        isSuccess: true,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to delete profile');
    }
  }

  void clearError()   => state = state.copyWith(clearError: true);
  void clearSuccess() => state = state.copyWith(clearSuccess: true);
}

final professionalRepositoryProvider =
    Provider<ProfessionalRepositoryImpl>((_) => ProfessionalRepositoryImpl());

final professionalProvider =
    StateNotifierProvider<ProfessionalNotifier, ProfessionalState>((ref) =>
        ProfessionalNotifier(ref.read(professionalRepositoryProvider)));