import 'package:eduproject/utils/colors.dart';
import 'package:eduproject/utils/textfield_deco.dart';
import 'package:eduproject/utils/validator.dart';
import 'package:eduproject/view_models/registration_view_model.dart';
import 'package:eduproject/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _showPassword = false;

  togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewModel = Provider.of<RegistrationViewModel>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: EduProColors.text,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                "Welcome!",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter-SemiBold',
                    color: EduProColors.text),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                '''Email ID''',
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
                '''Password''',
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
                obscureText: _showPassword,
                validator: loginValidatePassword,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: InkWell(
                      mouseCursor: MaterialStateMouseCursor.clickable,
                      onTap: () {
                        togglevisibility();
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                        color: EduProColors.text,
                      )),
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: Colors.white,
                backgroundColor: EduProColors.primary.withOpacity(0.7),
                //maximumSize: const Size(400, 37),
              ),
              onPressed: () async {
                final email = emailcontroller.text;
                final password = passwordcontroller.text;

                final success = await viewModel.loginUser(email, password);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login successful')),
                  );

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileView()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login failed')),
                  );
                }
              },
              child: const Center(
                child: Text(
                  'Log in',
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
