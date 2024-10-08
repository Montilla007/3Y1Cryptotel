import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hotel_flutter/data/repositories/auth_repository.dart';
import 'package:hotel_flutter/logic/bloc/auth/auth_event.dart';
import 'package:hotel_flutter/logic/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // Pass the profile picture if available
        final user = await authRepository.register(event.signUpModel,
            event.profilePicture != null ? File(event.profilePicture!) : null);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError('Registration failed: ${e.toString()}'));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.login(event.email, event.password);
        emit(AuthenticatedLogin(user)); // Pass the LoginModel directly
      } catch (e) {
        print("Login Error: $e");
        emit(AuthError('Login failed: ${e.toString()}'));
      }
    });
    on<ForgotPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.forgotPassword(event.email);
        emit(const AuthSuccess('Reset link sent to your email'));
      } catch (e) {
        emit(AuthError('Failed to send reset link: ${e.toString()}'));
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.resetPassword(
            event.token, event.newPassword, event.confirmPassword);
        emit(const AuthSuccess('Password reset successful'));
      } catch (e) {
        emit(AuthError('Failed to reset password: ${e.toString()}'));
      }
    });

    on<FetchAllUsersEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final users = await authRepository.fetchAllUsers();
        emit(UsersFetched(users));
      } catch (e) {
        emit(AuthError('Failed to fetch users: ${e.toString()}'));
      }
    });

    on<GetUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.getUser(event.userId);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError('Failed to fetch user data: ${e.toString()}'));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.updatePassword(
          event.oldPassword,
          event.newPassword,
          event.confirmPassword,
        );
        emit(const AuthSuccess('Password changed successfully'));
      } catch (e) {
        emit(AuthError('Failed to change password: ${e.toString()}'));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // Ensure both firstName, lastName, and profilePicture are sent to the repository
        final updatedUser = await authRepository.updateUser(
          event.user,
          profilePicture:
              event.profilePicture != null ? File(event.profilePicture!) : null,
        );
        emit(Authenticated(
            updatedUser)); // Emit the updated user after the operation is successful
      } catch (error) {
        emit(AuthError('Failed to update user: $error'));
      }
    });

    on<VerifyUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.verifyUser(event.email, event.code);
        emit(const AuthSuccessVerification('Verification successful!'));
      } catch (e) {
        emit(AuthError('Verification failed: ${e.toString()}'));
      }
    });

    on<LogoutEvent>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          await authRepository.logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthError('Failed to logout: ${e.toString()}'));
        }
      },
    );

    // Handle the CompleteOnboardingEvent
    on<CompleteOnboardingEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.completeOnboarding();
        emit(const AuthSuccess('Onboarding completed successfully'));
      } catch (e) {
        emit(AuthError('Failed to complete onboarding: ${e.toString()}'));
      }
    });
  }
}
