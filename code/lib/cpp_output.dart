import 'package:developer_assistant/cplusplus.dart';
import 'package:flutter/material.dart';

class Mycpp_output extends StatefulWidget {
  @override
  _Mycpp_outputState createState() => _Mycpp_outputState();
}

class _Mycpp_outputState extends State<Mycpp_output> {
  var output;

  @override
  void initState() {
    output = MyCplusplus.c_op;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C++ Output'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.all(50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(20),
              // color: Colors.grey,

              child: Text(
                output,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}
