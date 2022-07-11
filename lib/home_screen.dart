import 'dart:math';

import 'package:bmi_calculator/result_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int weight = 70;
  int age = 20;
  double height = 160;
  double result = 0;
  bool isMale = true;
  late double heightPhone;

  @override
  Widget build(BuildContext context) {
    double heightPhone = MediaQuery.of(context).size.height.toDouble();
     heightPhone=heightPhone;
    double widthPhone = MediaQuery.of(context).size.width.toDouble();
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Health Calculator'))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  buildMaleFemaleContainer(heightPhone, 'Male'),
                  SizedBox(width: widthPhone / 15),
                  buildMaleFemaleContainer(heightPhone, 'Female'),
                ],
              ),
            ),
            SizedBox(height: heightPhone / 40),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: heightPhone / 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic , 
                      children: [
                        Text('${height.toStringAsFixed(1)}',
                            style: Theme.of(context).textTheme.headline1,),
                        SizedBox(width: widthPhone / 50),
                        Text(
                          'CM',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    Slider(
                      min: 30,
                      max: 220,
                      value: height,
                      onChanged: (newVal) {
                        setState(() {
                          height = newVal;
                        });
                      },
                      activeColor: Colors.amber,
                      inactiveColor: Colors.white,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            SizedBox(height: heightPhone / 40),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildWeightAgeContainer(
                        'Weight', widthPhone, heightPhone),
                  ),
                  SizedBox(width: widthPhone / 15),
                  Expanded(
                    child:
                        buildWeightAgeContainer('Age', widthPhone, heightPhone),
                  ),
                ],
              ),
            ),
            SizedBox(height: heightPhone / 40),
            InkWell(
              onTap: () {
                setState(() {
                  result = weight / pow(height / 100, 2);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ResultScreen(
                        result: result, isMale: isMale, age: age,heightPhone:heightPhone);
                  }),
                );
              },
              child: Container(
                width: double.infinity,
                height: heightPhone / 14,
                child: Center(
                  child: Text(
                    'Calculate',
                    style: Theme.of(context).textTheme.headline2!.copyWith(letterSpacing: 6),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildMaleFemaleContainer(double heightPhone, String maleOrFemale) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            isMale = maleOrFemale == 'Male' ? true : false;
          });
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                maleOrFemale == 'Male' ? Icons.male : Icons.female,
                size: heightPhone / 10,
                color: Colors.white,
              ),
              SizedBox(height: heightPhone / 50),
              Text(
                maleOrFemale == 'Male' ? 'Male' : 'Female',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: ((maleOrFemale == 'Male' && isMale) ||
                    (maleOrFemale == 'Female' && !isMale))
                ? Colors.amber
                : Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  GestureDetector buildWeightAgeContainer(
      String weightAgeText, double widthPhone, double heightPhone) {
    return GestureDetector(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weightAgeText,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: heightPhone / 70),
            Text(
              weightAgeText == 'Weight' ? weight.toString() : age.toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        weightAgeText == 'Weight' ? weight-- : age--;
                      });
                    },
                    child: Icon(Icons.remove, color: Colors.white),
                    mini: true,
                    heroTag:
                        weightAgeText == 'Weight' ? ' weight-- ' : 'age--,'),
                SizedBox(width: widthPhone / 20),
                FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        weightAgeText == 'Weight' ? weight++ : age++;
                      });
                    },
                    child: Icon(Icons.add, color: Colors.white),
                    mini: true,
                    heroTag: weightAgeText == 'Weight' ? 'weight++' : 'age++'),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
