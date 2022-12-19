import 'package:flutter/material.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myBody(),
    );
  }

  Container myBody() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Set a consistent bedtime to get a better night's sleep",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const Padding(
            padding: EdgeInsets.only(top: 32.0, right: 20.0, left: 20.0),
            child: Text(
                "Keep a regular bedtime, disconnect from your smartphone and listen to relaxing sounds",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center),
          ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 24.0),
           child: ClipRRect(
             borderRadius: BorderRadius.circular(16.0),
               child: Image.asset("assets/images/sleep.gif", height: 250)),
         ),
          /*const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Icon(Icons.bed, size: 250),
          ),*/
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
            ),
            child: const Text("Start", style: TextStyle(color: Colors.black87)),
          )
        ],
      ),
    );
  }
}
