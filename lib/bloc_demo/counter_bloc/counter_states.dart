class CounterStates {
  int counter;
  CounterStates({required this.counter});
}

class InitialState extends CounterStates {
  InitialState() : super(counter: 1) {
    print("InitialState()  constructor called");
  }
}
