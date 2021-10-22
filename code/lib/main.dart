import 'package:developer_assistant/c_code.dart';
import 'package:developer_assistant/c_output.dart';
import 'package:developer_assistant/cplusplus.dart';
import 'package:developer_assistant/cpp_output.dart';

import 'package:developer_assistant/ip.dart';
import 'package:developer_assistant/linux.dart';
import 'package:developer_assistant/listfiles.dart';
import 'package:developer_assistant/myhome.dart';
import 'package:developer_assistant/python.dart';
import 'package:developer_assistant/python_output.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'listfiles',
    routes: {
      'ip': (context) => MyIp(),
      'home': (context) => MyHome(),
      'python': (context) => MyPython(),
      'python_output': (context) => MyPythonOutput(),
      'ccode': (context) => MyC_code(),
      'c_output': (context) => MyC_output(),
      'cppcode': (context) => MyCplusplus(),
      'cpp_output': (context) => Mycpp_output(),
      'linux': (context) => MyLinux(),
      'listfiles': (context) => MyListFiles()
    },
  ));
}
