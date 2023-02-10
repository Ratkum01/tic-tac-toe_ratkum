// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool ohTurn = true; // 0 or X
  List<String> displayExoh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  var myTextStyle = GoogleFonts.itim(
      textStyle: TextStyle(
    color: Color(0xFFF3FD00),
    fontSize: 30,
  ));

  int exScore = 0;
  int eoScore = 0;
  int filledBoxes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7908AA),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 30, right: 10),
                      child: Column(
                        children: [
                          Text(
                            'Oyinshi "О" ',
                            style: myTextStyle,
                          ),
                          Text(eoScore.toString(), style: myTextStyle)
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 30, right: 10),
                      child: Column(
                        children: [
                          Text('Oyinshi "X"', style: myTextStyle),
                          Text(exScore.toString(), style: myTextStyle)
                        ],
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Color(0xFFF3FD00))),
                    child: Center(
                        child: Text(
                      displayExoh[index],
                      style: TextStyle(color: Color(0xFFF3FD00), fontSize: 80),
                    )),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              children: [
                Text(
                  ' X jane O ',
                  style: GoogleFonts.itim(
                      textStyle: TextStyle(
                    color: Color(0xFFF3FD00),
                    fontSize: 40,
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '@ratkum.apk',
                  style: myTextStyle,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  //poverka pusto or no. ne mojem stavit odnom meste dva raza
  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExoh[index] == '') {
        displayExoh[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayExoh[index] == '') {
        displayExoh[index] = 'X';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  //metod dlya proverki pobeditelya
  void _checkWinner() {
    //perviy ryad horizantal
    if (displayExoh[0] == displayExoh[1] &&
        displayExoh[0] == displayExoh[2] &&
        displayExoh[0] != '') {
      _showWinDialog(displayExoh[0]);
    }
    //vtoroy ryad horizantal
    if (displayExoh[3] == displayExoh[4] &&
        displayExoh[3] == displayExoh[5] &&
        displayExoh[3] != '') {
      _showWinDialog(displayExoh[3]);
    }
    //treti ryad horizantal
    if (displayExoh[6] == displayExoh[7] &&
        displayExoh[6] == displayExoh[8] &&
        displayExoh[6] != '') {
      _showWinDialog(displayExoh[6]);
    }
    //perviy ryad vertical
    if (displayExoh[0] == displayExoh[3] &&
        displayExoh[0] == displayExoh[6] &&
        displayExoh[0] != '') {
      _showWinDialog(displayExoh[0]);
    }
    //vtoroy ryad vertical
    if (displayExoh[1] == displayExoh[4] &&
        displayExoh[1] == displayExoh[7] &&
        displayExoh[1] != '') {
      _showWinDialog(displayExoh[1]);
    }
    //trety ryad vertical
    if (displayExoh[2] == displayExoh[5] &&
        displayExoh[2] == displayExoh[8] &&
        displayExoh[2] != '') {
      _showWinDialog(displayExoh[2]);
    }
    //diagonal one
    if (displayExoh[0] == displayExoh[4] &&
        displayExoh[0] == displayExoh[8] &&
        displayExoh[0] != '') {
      _showWinDialog(displayExoh[0]);
    }
    //diagonal two
    if (displayExoh[6] == displayExoh[4] &&
        displayExoh[6] == displayExoh[2] &&
        displayExoh[6] != '') {
      _showWinDialog(displayExoh[6]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

//dialog pobeditelya
  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false, // kerek funcion , sirtin basip shykpas ushin
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF7908AA),
            title: Text('ALAQAY !!! Oyinshy $winner jendi' , style: TextStyle(color: Color(0xFFF3FD00)),),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Тағыда ойнау', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))))
            ],
          );
        });
    if (winner == 'O') {
      eoScore += 1;
    } else if (winner == 'X') {
      exScore += 1;
    }
  }

  //dialog nechya
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false, // kerek funcion , sirtin basip shykpas ushin
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFF7908AA),
            title: Text('Өкінішке орай ешкім жеңбеді' , style: TextStyle(color: Color(0xFFF3FD00)),),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Тағыда ойнау' , style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),))
            ],
          );
        });
  }

  //ochistka kvadratov
  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExoh[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
