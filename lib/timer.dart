// for sent opt page

import 'dart:async';

import 'package:flutter/material.dart';

class SendOtpTimerPage extends StatefulWidget {
  const SendOtpTimerPage({super.key});

  @override
  State<SendOtpTimerPage> createState() => _SendOtpTimerPageState();
}

class _SendOtpTimerPageState extends State<SendOtpTimerPage> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 10);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(10));

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Like OTP send Timer",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            Text(
              "00 :$seconds",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
            const SizedBox(
              height: 150,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.redAccent; //<-- SEE HERE
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () {
                  startTimer();
                  print("PRESS");
                },
                child: const Text(
                  "  Send OTP  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.redAccent; //<-- SEE HERE
                      }
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                onPressed: () {
                  resetTimer();
                  startTimer();
                  print("PRESS");
                },
                child: const Text(
                  "  Resent OTP  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                )),
          ],
        )));
  }
}
