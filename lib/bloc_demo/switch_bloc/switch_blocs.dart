import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class SwitchEvent {}

class ToggleSwitchEvent extends SwitchEvent {}

// States
abstract class SwitchState {}

class SwitchOnState extends SwitchState {}

class SwitchOffState extends SwitchState {}

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchOffState());

  @override
  Stream<SwitchState> mapEventToState(SwitchEvent event) async* {
    if (event is ToggleSwitchEvent) {
      yield state is SwitchOnState ? SwitchOffState() : SwitchOnState();
    }
  }
}
