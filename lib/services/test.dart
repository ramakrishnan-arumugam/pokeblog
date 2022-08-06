import 'package:pokeblog/services/paint.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class authtest extends StatefulWidget {
  const authtest({Key? key}) : super(key: key);

  @override
  State<authtest> createState() => _authtestState();
}
class _authtestState extends State<authtest> {

  @override
  Future signup() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: 'sriram2002.rk@gmail.com', password: 'admin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('authtest'),),
      body:Container(), floatingActionButton :FloatingActionButton(
      onPressed: (){
        signup();
      },
    ),
    );
  }
}




























// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black38,
//           foregroundColor: Colors.green,
//           title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(
//               'Poke',
//               style: TextStyle(fontSize: 22),
//             ),
//             Text(
//               "Blog",
//               style: TextStyle(fontSize: 22, color: Colors.lightBlue),
//             )
//           ]),
//         ),
//         body: Container(
//           child: CustomPaint(
//             painter: HeaderPainter(),
//             size: const Size(double.infinity, double.infinity),
//           ),
//         ));
//   }
// }
