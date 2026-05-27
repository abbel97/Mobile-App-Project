import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/failure.dart';
import '../../data/repositories/professional_repository_impl.dart';
import '../../domain/entities/professional_entity.dart';

class ProfessionalState {
	final ProfessionalEntity? profile;
	final bool isLoading;
	final bool isSaving;
	final String? error;
	final bool isSuccess;

	const ProfessionalState({
		this.profile,
		this.isLoading = false,
		this.isSaving = false,
		this.error,
		this.isSuccess = false,
	});

	ProfessionalState copyWith({
		ProfessionalEntity? profile,
		bool? isLoading,
		bool? isSaving,
		String? error,
		bool? isSuccess,
		bool clearError = false,
		bool clearSuccess = false,
	}) {
		return ProfessionalState(
			profile: profile ?? this.profile,
			isLoading: isLoading ?? this.isLoading,
			isSaving: isSaving ?? this.isSaving,
			error: clearError ? null : error ?? this.error,
			isSuccess: clearSuccess ? false : isSuccess ?? this.isSuccess,
		);
	}
}

class ProfessionalNotifier extends StateNotifier<ProfessionalState> {
	final ProfessionalRepositoryImpl _repo;

	ProfessionalNotifier(this._repo) : super(const ProfessionalState());

	Future<void> loadMyProfile() async {
		state = state.copyWith(isLoading: true, clearError: true);
		try {
			final profile = await _repo.getMyProfile();
			state = state.copyWith(profile: profile, isLoading: false);
		} on Failure catch (e) {
			state = state.copyWith(isLoading: false, error: e.message);
		} catch (_) {
			state = state.copyWith(isLoading: false, error: 'Failed to load profile');
		}
	}

	Future<void> updateMyProfile({
		required String name,
		required String email,
		required String profession,
		required String bio,
		required String location,
		required int experienceYears,
		required double serviceRate,
		required String educationLevel,
	}) async {
		state = state.copyWith(isSaving: true, clearError: true, clearSuccess: true);
		try {
			final profile = await _repo.updateMyProfile(
				name: name,
				email: email,
				profession: profession,
				bio: bio,
				location: location,
				experienceYears: experienceYears,
				serviceRate: serviceRate,
				educationLevel: educationLevel,
			);
			state = state.copyWith(profile: profile, isSaving: false, isSuccess: true);
		} on Failure catch (e) {
			state = state.copyWith(isSaving: false, error: e.message);
		} catch (_) {
			state = state.copyWith(isSaving: false, error: 'Failed to update profile');
		}
	}

	void clearError() => state = state.copyWith(clearError: true);
	void clearSuccess() => state = state.copyWith(clearSuccess: true);
}

final professionalRepositoryProvider = Provider<ProfessionalRepositoryImpl>(
	(_) => ProfessionalRepositoryImpl(),
);

final professionalProvider =
		StateNotifierProvider<ProfessionalNotifier, ProfessionalState>((ref) {
	return ProfessionalNotifier(ref.read(professionalRepositoryProvider));
});
