import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrgProfile extends StatelessWidget {

  const OrgProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Profile',
              style: TextStyle(color: Color(0xFFFFC107)),
              ),
        backgroundColor: const Color.fromARGB(255, 8, 64, 60),
      ),
      body: Column(
        children: [ 
          SingleChildScrollView(
            child: Container(
              color: const Color(0xFF9F1010),
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              height: 175.0,
              child: const Column(
                children: [
                  //edit button
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: FittedBox(
                        child: FloatingActionButton(
                          onPressed: null,
                          child: Icon(CupertinoIcons.pencil)
                        ),
                      ),
                    )
                  ),
                  Row(
                    children: [
                      Text('<logo>', style: TextStyle(color: Color(0xFFFFC107))),
                      SizedBox(width: 20.0),
                      Text('<Charity Name>', style: TextStyle(color: Color(0xFFFFC107))),
                    ],)
                ],
              ),
            )
          )
        ],
      ),

    );
  }
}


// child: ElevatedButton(
        //   child: const Text('Go to Second route'),
        //     onPressed: () {
        //     // Navigate to second route
        //     },
        //   ),