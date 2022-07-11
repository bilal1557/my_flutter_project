import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.result,
    required this.isMale,
    required this.age,
    required this.heightPhone,
  }) : super(key: key);

  final double result;
  final bool isMale;
  final int age;
  final double heightPhone;

  String get textHealthiness {
    String text = '';

    if (result >= 30)
      text = 'Obese';
    else if (result >= 25 && result < 30)
      text = 'OverWeight';
    else if (result >= 18.5 && result < 25)
      text = 'Normal';
    else
      text = 'Thin';

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: heightPhone / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Your Results :',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.amber,
                        fontSize: 40,
                      ),
                ),
                Text('Gender : ${isMale ? "Male" : 'Female'}',
                    style: Theme.of(context).textTheme.headline2),
                Text(
                  'Result : ${result.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  'Healthiness : $textHealthiness ',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
                Text('Age : $age',
                    style: Theme.of(context).textTheme.headline2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
