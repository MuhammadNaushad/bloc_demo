import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'switch_bloc/switch_blocs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: BlocProvider(
        create: (context) => SwitchBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Switch BLoC Example")),
      body: Center(
        child: BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {
            return Switch(
              value: true,
              onChanged: (_) {
                BlocProvider.of<SwitchBloc>(context).add(ToggleSwitchEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
