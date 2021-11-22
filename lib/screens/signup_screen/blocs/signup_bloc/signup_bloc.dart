import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event,) async* {
    if (event is SignUp) {
      yield* _fakeToState(event);
    }
  }

  Stream<SignUpState> _fakeToState(SignUpEvent event,) async* {
    yield state.copyWith(status: state.status == SignUpStatus.success ? SignUpStatus.initial : SignUpStatus.success,);
  }
}
