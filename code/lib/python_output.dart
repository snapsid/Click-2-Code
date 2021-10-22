import 'package:developer_assistant/python.dart';
import 'package:flutter/material.dart';

class MyPythonOutput extends StatefulWidget {
  @override
  _MyPythonOutputState createState() => _MyPythonOutputState();
}

class _MyPythonOutputState extends State<MyPythonOutput> {
  var output;

  @override
  void initState() {
    output = MyPython.python_op;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Output'),
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
