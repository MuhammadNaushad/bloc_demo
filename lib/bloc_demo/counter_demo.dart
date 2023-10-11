import 'package:bloc_demo/bloc_demo/counter_bloc/counter_events.dart';
import 'package:bloc_demo/bloc_demo/counter_bloc/counter_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc/counter_blocs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<CounterBloc>(
        create: (_) => CounterBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Build() called");
    return Scaffold(
      body: BlocBuilder<CounterBloc, CounterStates>(builder: (context, state) {
        return Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.counter.toString(),
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<CounterBloc>(context).add(Increment()),
                    child: const Icon(Icons.add)),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () =>
                        BlocProvider.of<CounterBloc>(context).add(Decrement()),
                    child: const Icon(Icons.remove))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondPage()));
              },
              child: Container(
                width: 138,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: const Center(
                    child: Text(
                  "click",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            /* Switch(
  // thumb color (round icon)
  activeColor: Colors.amber,
  activeTrackColor: Colors.cyan,
  inactiveThumbColor: Colors.blueGrey.shade600,
  inactiveTrackColor: Colors.grey.shade400,
  splashRadius: 50.0,
  // boolean variable value
  value: forAndroid,
  // changes the state of the switch
  onChanged: (value) => setState(() => forAndroid = value),
), */
          ],
        );
      }),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blocs"),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder(
            bloc: counterBloc,
            builder: (context, state) {
              return Center(
                child: Text(
                  counterBloc.state.counter.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
              );
            }));
  }
}
