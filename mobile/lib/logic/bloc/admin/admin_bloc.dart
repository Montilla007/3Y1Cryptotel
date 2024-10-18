import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_flutter/data/repositories/admin_repository.dart';
import 'package:hotel_flutter/logic/bloc/admin/admin_event.dart';
import 'package:hotel_flutter/logic/bloc/admin/admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc({required this.adminRepository}) : super(AdminInitial()) {
    on<CreateHotelEvent>(_onCreateHotel);
    on<CreateRestaurantEvent>(_onCreateRestaurant);
  }

  // Handle Hotel Creation
  Future<void> _onCreateHotel(
      CreateHotelEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());

    try {
      final response = await adminRepository.createHotel(event.adminModel);
      emit(AdminSuccess('Hotel created successfully!'));
    } catch (e) {
      emit(AdminFailure('Failed to create hotel: ${e.toString()}'));
    }
  }

  // Handle Restaurant Creation
  Future<void> _onCreateRestaurant(
      CreateRestaurantEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());

    try {
      final response = await adminRepository.createRestaurant(event.adminModel);
      emit(AdminSuccess('Restaurant created successfully!'));
    } catch (e) {
      emit(AdminFailure('Failed to create restaurant: ${e.toString()}'));
    }
  }
}
