import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
  ));
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Provier"),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider(
          create: (context) => DemoProvider(),
          child: Consumer<DemoProvider>(
            builder: (context, val, child) {
              return Column(
                children: [
                  Text(
                    val.eligible_message.toString(),
                    style: TextStyle(
                      color: (val.eligible == true) ? Colors.green : Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        if(value.isEmpty){
                          val.checkEligible(0);
                        }
                        else{
                          val.checkEligible(int.parse(value));
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "enter your age",
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}

class DemoProvider extends ChangeNotifier {
  bool? eligible;
  String? eligible_message = "";

  void checkEligible(int age) {
    if (age >= 18) {
      eligible = true;
      eligible_message = "you are eligible";
      notifyListeners();
    } else {
      eligible = false;
      eligible_message = "you are not eligible";
      notifyListeners();
    }
  }
}
