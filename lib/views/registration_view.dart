

import 'package:eduproject/utils/colors.dart';
import 'package:eduproject/utils/textfield_deco.dart';
import 'package:eduproject/utils/validator.dart';
import 'package:eduproject/view_models/registration_view_model.dart';
import 'package:eduproject/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController fullnamecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool istutorial = true;

  String location = '';
  togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    fullnamecontroller.dispose();
    passwordcontroller.dispose();
    addresscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegistrationViewModel>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formkey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Text(
                "Create Account",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter-SemiBold',
                    color: EduProColors.text),
              ),
            ),
            SizedBox(height: size.height * 0.025),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '''Enter Email address''',
                overflow: TextOverflow.visible,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 14.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
              ),
            ),
            TextFormField(
                validator: loginValidateEmail,
                controller: emailcontroller,
                decoration: builInputDecoration("Email", const Icon(null))),
            SizedBox(height: size.height * 0.020),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '''Enter Password''',
                overflow: TextOverflow.visible,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 14.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
              ),
            ),
            TextFormField(
                validator: loginValidatePassword,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: EduProColors.bgcolor,
                  hintText: "Password",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: EduProColors.bgcolor, width: 1.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: EduProColors.bgcolor,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: EduProColors.bgcolor,
                      width: 1.5,
                    ),
                  ),
                )),
            SizedBox(height: size.height * 0.020),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '''Enter Full Name''',
                overflow: TextOverflow.visible,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 14.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
              ),
            ),
            TextFormField(
                controller: fullnamecontroller,
                decoration: builInputDecoration("Full Name", const Icon(null))),
            SizedBox(height: size.height * 0.020),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '''Address''',
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: addresscontroller,
              readOnly: false,
              decoration: builInputDecoration("Address", null),
              maxLines: 3,
            ),
            SizedBox(height: size.height * 0.020),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: EduProColors.primary.withOpacity(0.7),
                  maximumSize: const Size(400, 37)),
              onPressed: () async {
                if (formkey.currentState?.validate() ?? true) {
                  final success = await viewModel.registerUser(
                    fullnamecontroller.text,
                    addresscontroller.text,
                    emailcontroller.text,
                    passwordcontroller.text,
                  );
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration successful')),
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const LoginView()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration failed')),
                    );
                  }
                }
              },
              child: const Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Inter-Regular',
                  ),
                ),
              ),
            ),
          ]),
        ),
      )),
    ));
  }
}
