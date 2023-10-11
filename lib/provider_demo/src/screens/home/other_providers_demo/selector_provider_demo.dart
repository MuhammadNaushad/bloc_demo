import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<NumberProvider>(create: (_) => NumberProvider())
    ],
    child:
        const MaterialApp(home: 1 == 2 ? ConsummerScreen() : SelectorScreen()),
  ));
}

class ConsummerScreen extends StatelessWidget {
  const ConsummerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'all',
            onPressed: () {
              context.read<NumberProvider>().add();
            },
            child: const Text('all'),
          ),
          FloatingActionButton(
            heroTag: '1',
            onPressed: () {
              context.read<NumberProvider>().addTo1();
            },
            child: const Text('1'),
          ),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () {
              context.read<NumberProvider>().addTo2();
            },
            child: const Text('2'),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<NumberProvider>(
                builder: (context, provider, child) {
                  debugPrint('rebuild consumer1');
                  return Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(10),
                    child: Text('${provider.number1}'),
                  );
                },
              ),
              Consumer<NumberProvider>(
                builder: (context, provider, child) {
                  debugPrint('rebuild consumer2');
                  return Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(10),
                    child: Text('${provider.number2}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectorScreen extends StatelessWidget {
  const SelectorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'all',
            onPressed: () {
              context.read<NumberProvider>().add();
            },
            child: const Text('all'),
          ),
          FloatingActionButton(
            heroTag: '1',
            onPressed: () {
              context.read<NumberProvider>().addTo1();
            },
            child: const Text('1'),
          ),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () {
              context.read<NumberProvider>().addTo2();
            },
            child: const Text('2'),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Selector<NumberProvider, dynamic>(
                  selector: (_, provider) => provider.number1,
                  builder: (context, number1, child) {
                    debugPrint('Selector Build num1');
                    return Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(10),
                      child: Text('$number1'),
                    );
                  }),
              Selector<NumberProvider, int>(
                  selector: (_, provider) => provider.number2,
                  builder: (context, number2, child) {
                    debugPrint('Selector Build num2');
                    return Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(10),
                      child: Text('$number2'),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberProvider extends ChangeNotifier {
  int _number1 = 0;
  int _number2 = 1;
  int get number1 => _number1;
  int get number2 => _number2;

  void add() {
    _number1++;
    _number2++;
    notifyListeners();
  }

  void addTo1() {
    _number1++;
    notifyListeners();
  }

  void addTo2() {
    _number2++;
    notifyListeners();
  }
}
