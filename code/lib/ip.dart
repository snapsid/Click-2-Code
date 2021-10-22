import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyIp extends StatefulWidget {
  static String ip_public = "13.235.244.11";
  @override
  _MyIpState createState() => _MyIpState();
}

class _MyIpState extends State<MyIp> {
  var ip;
  onSubmit() async {
    var url = Uri.parse('http://${ip}/check.html');
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
        if (body == 'hello DA\n') {
          Navigator.pushNamed(context, 'home');
        } else {
          print('nooo');
        }
      } else {
        print('invalid IP');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Developer Assistant'),
          backgroundColor: Colors.teal,
        ),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    ip = value;
                    MyIp.ip_public = ip;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Enter your IP",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.teal,
                elevation: 5,
                child: MaterialButton(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onSubmit();
                  },
                  minWidth: 130,
                  height: 40,
                ),
              ),
            ],
          ),
        ));
  }
}
