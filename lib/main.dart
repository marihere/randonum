import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randonum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Randonum'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller1 = TextEditingController(text: '1');
  final TextEditingController _controller2 = TextEditingController(text: '10');
  bool generated = false;
  int generatedNumber = 0;

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
                'The first number must be smaller than the second one! 🤏'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _generateRandNumber() {
    int num1 = int.parse(_controller1.text);
    int num2 = int.parse(_controller2.text);
    if (num2 >= num1) {
      setState(() {
        generated = true;
        generatedNumber = Random().nextInt(num2) + num1;
      });
    } else {
      _dialogBuilder(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 42),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _controller1,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: _controller2,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: false, signed: false),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 42),
              child: TextButton(
                onPressed: _generateRandNumber,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.inversePrimary)),
                child: Text(
                  'Generate',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const Text('Generated number:'),
            generated
                ? Text(
                    '$generatedNumber',
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
