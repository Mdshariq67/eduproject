import 'package:eduproject/models/user_models.dart';
import 'package:eduproject/utils/colors.dart';
import 'package:eduproject/utils/textfiled_custom.dart';
import 'package:eduproject/view_models/registration_view_model.dart';
import 'package:eduproject/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Profile? userProfile;
  String? fullname;
  TextEditingController addresscontroller = TextEditingController();

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('fullname') ?? '';
    final address = prefs.getString('address') ?? '';
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    setState(() {
      userProfile = Profile(
          fullName: firstName,
          address: address,
          email: email,
          password: password);
    });
  }

  void _fetchAddressDetails(String pincode) async {
    final Uri url = Uri.parse('https://api.postalpincode.in/pincode/$pincode');
    final response = await http.get(url);
  
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse[0]['Status'] == "Success") {
        final postOfficeData = decodedResponse[0]['PostOffice'][0];

        setState(() {
          addresscontroller.text =
              '${postOfficeData['District']}, ${postOfficeData['State']}, ${postOfficeData['Country']}';
        });
      } else {
        setState(() {
          addresscontroller.text = 'Failed to fetch address details';
        });
      }
    } else {
      setState(() {
        addresscontroller.text = 'Failed to fetch address details';
      });
    }
  }

  void updateadress() async {
    await _loadUserProfile();

    setState(() {
      addresscontroller.text = userProfile!.address;
    });
  }

  @override
  void initState() {
    _loadUserProfile();
    updateadress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewModel =
        Provider.of<RegistrationViewModel>(context, listen: false);

    void _logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      viewModel.isLoggedIn = false;
      viewModel.notifyListeners();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Textfieldwithtitle(
              controller: TextEditingController(text: userProfile?.fullName),
              size: size,
              title: "Full Name",
              hint: ""),
          const SizedBox(
            height: 10,
          ),
          Textfieldwithtitle(
              controller: TextEditingController(text: userProfile?.email),
              size: size,
              title: "Email",
              hint: ""),
          const SizedBox(
            height: 10,
          ),
          Textfieldwithtitle(
              controller: addresscontroller,
              size: size,
              title: "Address",
              hint: ""),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: _openPincodeDialog, // Open the pincode entry dialog
            child: const Text('Edit Address with Pincode'),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: EduProColors.primary,
              backgroundColor: EduProColors.bgcolor,
              // maximumSize: const Size(400, 37),
            ),
            onPressed: () {
              _logout();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.logout),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: EduProColors.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter-Regular',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController pincodeController = TextEditingController();
  void _openPincodeDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Postal Pincode'),
          content: TextField(
            controller: pincodeController,
            decoration: const InputDecoration(labelText: 'Pincode'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                if (pincodeController.text != '') {
                  _fetchAddressDetails(pincodeController.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
