import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/darcula.dart';

import 'ip.dart';

class MyCplusplus extends StatefulWidget {
  static String c_op;
  @override
  _MyCplusplusState createState() => _MyCplusplusState();
}

class _MyCplusplusState extends State<MyCplusplus> {
  String ip;
  Map<String, TextStyle> a = atomOneDarkTheme;
  var _codeController;

  @override
  Widget build(BuildContext context) {
    var source =
        '#include<iostream>\nusing namespace std;\n int main(){\n cout<<"hello cpp";\n}';
    var finalCode = "heyyy";
    _codeController = CodeController(
        text: source, language: cpp, theme: a, webSpaceFix: false);

    onrun() async {
      var cmd = _codeController.text;
      cmd = cmd.toString().replaceAll('#', '??');
      cmd = cmd.toString().replaceAll(';', '@@');
      cmd = cmd.toString().replaceAll('+', '.?');
      cmd = cmd.toString().replaceAll("'", '"');
      print(cmd);
      ip = MyIp.ip_public;
      // var url = Uri.parse('http://${ip}/cgi-bin/python/terminal.py');
      var url = Uri.parse('http://${ip}/cgi-bin/cpp_code/terminal.py?x=$cmd');
      try {
        var response = await http.get(url, headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        });
        var code = response.statusCode;
        print(code);
        if (code == 200) {
          var body = response.body;
          print(body);

          MyCplusplus.c_op = body;

          Navigator.pushNamed(context, 'cpp_output');
        } else {
          print('invalid IP');
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('C++ Terminal'),
        backgroundColor: Colors.teal,
        actions: [
          DropdownButton<String>(
            dropdownColor: Colors.blueGrey,
            elevation: 20,
            icon: Icon(Icons.color_lens_outlined),
            iconEnabledColor: Colors.white,
            items: <String>['Atom', 'Monokai-sublime', 'VS', 'Darcula']
                .map((String value) {
              return new DropdownMenuItem<String>(
                onTap: () {
                  print(value);
                  setState(() {
                    if (value == 'Monokai-sublime') {
                      a = monokaiSublimeTheme;
                    } else if (value == 'VS') {
                      a = vsTheme;
                    } else if (value == 'Atom') {
                      a = atomOneDarkTheme;
                    } else if (value == 'Darcula') {
                      a = darculaTheme;
                    }
                  });
                },
                value: value,
                child: new Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (_) {},
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          onrun();
        },
        child: Icon(Icons.play_arrow),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // alignment: Alignment.center,
                // height: MediaQuery.of(context).size.height * 0.8,

                child: CodeField(
                  controller: _codeController,
                  textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: 20),
                ),
              ),
              // Container(
              //   child: CircleAvatar(
              //     minRadius: 30,
              //     backgroundColor: Colors.teal,
              //     child: IconButton(
              //       splashColor: Colors.teal,
              //       focusColor: Colors.orange,
              //       highlightColor: Colors.blue,
              //       color: Colors.white,
              //       icon: Icon(Icons.play_arrow),
              //       onPressed: () async {
              //         print(cmd);
              //         ip = MyIp.ip_public;
              //         // var url = Uri.parse('http://${ip}/cgi-bin/python/terminal.py');
              //         var url = Uri.parse(
              //             'http://192.168.1.12/cgi-bin/python/test.py?x=$cmd');
              //         try {
              //           var response = await http.get(url, headers: {
              //             "Accept": "application/json",
              //             "Access-Control_Allow_Origin": "*"
              //           });
              //           var code = response.statusCode;
              //           print(code);
              //           if (code == 200) {
              //             var body = response.body;
              //             print(body);
              //           } else {
              //             print('invalid IP');
              //           }
              //         } catch (e) {
              //           print(e);
              //         }
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
