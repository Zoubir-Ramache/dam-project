// import 'package:dam_project/Screens/login.dart';
import 'package:flutter/material.dart';
// import '/Screens/login.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.buttonName,
    required this.cont,
    required this.handleData,
  });
  final Function(String , String , BuildContext) handleData;
  final String buttonName;
  final BuildContext cont;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();

    return Column(
      key: Key(buttonName),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          buttonName,
          style: const TextStyle(
            color: Color.fromARGB(255, 15, 3, 247),
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 500,
          child: Card(
            shadowColor: Colors.black,
            elevation: 15,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration:
                        const InputDecoration(label: Text('enter your email ')),
                    controller: controller1,
                    
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(label: Text('password')),
                    controller: controller2,
                    keyboardType: TextInputType.none,
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SwitchAuthMode(buttonName, cont: cont),
                      ElevatedButton(
                        onPressed: () {
                          handleData(controller1.text, controller2.text, cont);
                          // handleData(controller1.text, controller2.text, cont);
                        },
                        child: Text(buttonName),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class SwitchAuthMode extends StatelessWidget {
  const SwitchAuthMode(this.name, {super.key, required this.cont});
  final String name;
  final BuildContext cont;
  @override
  Widget build(BuildContext context) {
    return name == "signUp"
        ? (TextButton(
            onPressed: () {
              Navigator.of(cont).popAndPushNamed('/login');
            },
            child: const Text('already have an acount ?'),
          ))
        : (TextButton(
            onPressed: () {
              Navigator.of(cont).popAndPushNamed('/signup');
            },
            child: const Text('create new acount'),
          ));
  }
}
