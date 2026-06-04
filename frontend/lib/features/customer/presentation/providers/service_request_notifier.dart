import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure.dart';
import '../../data/repositories/service_request_repository_impl.dart';
import '../../domain/entities/service_request_entity.dart';

class ServiceRequestState {
  final List<ServiceRequestEntity> requests;
  final bool   isLoading;
  final String? error;
  final bool   isSuccess;

  const ServiceRequestState({
    this.requests  = const [],
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
  });

  ServiceRequestState copyWith({
    List<ServiceRequestEntity>? requests,
    bool?   isLoading,
    String? error,
    bool?   isSuccess,
    bool clearError   = false,
    bool clearSuccess = false,
  }) => ServiceRequestState(
        requests:  requests  ?? this.requests,
        isLoading: isLoading ?? this.isLoading,
        error:     clearError   ? null  : error     ?? this.error,
        isSuccess: clearSuccess ? false : isSuccess ?? this.isSuccess,
      );
}

class ServiceRequestNotifier extends StateNotifier<ServiceRequestState> {
  final ServiceRequestRepositoryImpl _repo;

  ServiceRequestNotifier(this._repo) : super(const ServiceRequestState()) {
    loadRequests();
  }

  Future<void> loadRequests() async {
    state = state.copyWith(isLoading: true, clearError: true, requests: const []);
    try {
      final list = await _repo.getRequests();
      state = state.copyWith(requests: list, isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to load requests');
    }
  }

  Future<void> refreshRequests() async {
    state = state.copyWith(isLoading: true, clearError: true, requests: const []);
    try {
      final list = await _repo.refreshRequests();
      state = state.copyWith(requests: list, isLoading: false);
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to refresh');
    }
  }

  Future<void> createRequest({
    required String title,
    required String description,
    required String profession,
    required String location,
    String urgency = 'regular',
    String? photoBase64,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);
    try {
      final r = await _repo.createRequest(
        title: title, description: description,
        profession: profession, location: location, urgency: urgency,
        photoBase64: photoBase64,
      );
      state = state.copyWith(
        requests:  [r, ...state.requests],
        isLoading: false,
        isSuccess: true,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to submit request');
    }
  }

  Future<void> updateRequest({
    required String id,
    String? title, String? description,
    String? profession, String? location, String? urgency,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);
    try {
      final updated = await _repo.updateRequest(
        id: id, title: title, description: description,
        profession: profession, location: location, urgency: urgency,
      );
      state = state.copyWith(
        requests:  state.requests.map((r) => r.id == id ? updated : r).toList(),
        isLoading: false,
        isSuccess: true,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to update request');
    }
  }

  Future<void> deleteRequest(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.deleteRequest(id);
      state = state.copyWith(
        requests:  state.requests.where((r) => r.id != id).toList(),
        isLoading: false,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to delete request');
    }
  }

  Future<void> acceptRequest(String id) async {
    state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);
    try {
      final accepted = await _repo.acceptRequest(id);
      state = state.copyWith(
        requests:  state.requests.map((r) => r.id == id ? accepted : r).toList(),
        isLoading: false,
        isSuccess: true,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to accept request');
    }
  }

  Future<void> applyRequest(String id) async {
  state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);
  try {
    final applied = await _repo.applyRequest(id);
    state = state.copyWith(
      requests:  state.requests.map((r) => r.id == id ? applied : r).toList(),
      isLoading: false,
      isSuccess: true,
    );
  } on Failure catch (e) {
    state = state.copyWith(isLoading: false, error: e.message);
  } catch (_) {
    state = state.copyWith(isLoading: false, error: 'Failed to apply');
  }
  }

  Future<void> confirmRequest({
    required String id,
    required String customerPhone,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true, clearSuccess: true);
    try {
      final confirmed = await _repo.confirmRequest(id: id, customerPhone: customerPhone);
      state = state.copyWith(
        requests:  state.requests.map((r) => r.id == id ? confirmed : r).toList(),
        isLoading: false,
        isSuccess: true,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to confirm');
    }
  }

  Future<void> rejectApplicant(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final updated = await _repo.rejectApplicant(id);
      state = state.copyWith(
        requests:  state.requests.map((r) => r.id == id ? updated : r).toList(),
        isLoading: false,
      );
    } on Failure catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
    } catch (_) {
      state = state.copyWith(isLoading: false, error: 'Failed to reject');
    }
  }

  void clearError()   => state = state.copyWith(clearError: true);
  void clearSuccess() => state = state.copyWith(clearSuccess: true);
}

final serviceRequestRepositoryProvider =
    Provider<ServiceRequestRepositoryImpl>((_) => ServiceRequestRepositoryImpl());

final serviceRequestProvider =
    StateNotifierProvider<ServiceRequestNotifier, ServiceRequestState>((ref) =>
        ServiceRequestNotifier(ref.read(serviceRequestRepositoryProvider)));