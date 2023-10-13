import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/repositories.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository authRepository;

  ForgetPasswordCubit(this.authRepository)
      : super(ForgetPasswordState.initial());

  Future<void> resetPassword({required String email}) async {
    if (state.status == ForgetPasswordStatus.loading) return;
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    try {
      await authRepository.sendResetPasswordEmail(email: email);
      emit(state.copyWith(
        status: ForgetPasswordStatus.success,
        success: 'resetPasswordEmailSent',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ForgetPasswordStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
