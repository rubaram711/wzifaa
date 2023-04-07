// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:shareapks/shareapk.dart';
// import 'package:shareapks/shareapks.dart';
//
//
//
// class MyProvider with ChangeNotifier, DiagnosticableTreeMixin {
//   var _iptext = "";
//
//   TextEditingController textcontroller;
//
//   MyProvider(this.textcontroller);
//
//   get iptext => _iptext;
//   var _loading = false;
//
//   get loading => _loading;
//
//   set loading(value) {
//     _loading = value;
//     print("------------->$value");
//     notifyListeners();
//   }
//
//   set iptext(value) {
//     print("---------------------->" + value);
//     _iptext = value;
//
//     notifyListeners();
//   }
// }
//
//
//
// class ShareMe extends StatefulWidget {
//   ShareMe({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _ShareMeState createState() => _ShareMeState();
// }
//
// class _ShareMeState extends State<ShareMe> {
//   int _counter = 0;
//   var _sharestate = Icons.share;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Shareapks.platformVersion;
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Container(
//               height: 48,
//               width: 48,
//               child: IconButton(
//                 icon: Icon(
//                   _sharestate,
//                   size: 30,
//                 ),
//                 color: Colors.white,
//                 onPressed: () async {
//                   await Shareapks.onShared!.listen((event) {
//                     if (event == "Finished") {
//                       setState(() {
//                         _sharestate = Icons.share;
//                       });
//
//                     } else {
//                       setState(() {
//                         _sharestate = Icons.watch;
//                       });
//
//                     }
//                   });
//                 },
//               )),
//         ],
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Stack(
//           children: [Share()],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//   var i = true;
// }