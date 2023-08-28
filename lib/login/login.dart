import 'package:add_to_cart_api/components/textfield.dart';
import 'package:add_to_cart_api/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyLoginScreen extends StatefulWidget {
  MyLoginScreen({
    super.key,
  });

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  ValueNotifier valueNotifierEmail = ValueNotifier(true);
  ValueNotifier valueNotifierPassword = ValueNotifier(true);
  late String animationUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyTextField(
                  controller: textEditingControllerEmail,
                  hintText: "Enter your email",
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              MyTextField(
                  controller: textEditingControllerPassword,
                  hintText: "Enter your Password",
                  prefixIcon: const Icon(
                    Icons.password,
                    color: Colors.black,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Consumer<HomeScreenStateMangement>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      value.isValidate(textEditingControllerEmail.text,
                          textEditingControllerPassword.text);
                      value.signIn(
                          context,
                          textEditingControllerEmail.text.toString(),
                          textEditingControllerPassword.text.toString());
                    },
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black),
                          color: Colors.blue),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
