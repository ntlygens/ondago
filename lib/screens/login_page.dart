import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/screens/register_page.dart';
import 'package:ondago/widgets/custom_btn.dart';
import 'package:ondago/widgets/custom_input.dart';
import 'package:ondago/widgets/device_detect.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool open = false;
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        // only dismissable by clicking button
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Container (
              child: Text(error),
            ),
            actions: [
              TextButton(
                child: const Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  // create new user account
  Future _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail,
          password: _loginPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // login user
  void _submitForm() async {
    // set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // run the create account method
    String? loginFeedback = await _loginAccount();

    // if string is not null error pops up
    if (loginFeedback != null) {
      _alertDialogBuilder(loginFeedback);

      // set the form to regular state: not loading
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // default loading state
  bool _loginFormLoading = false;

  // core input field values
  String _loginEmail = "";
  String _loginPassword = "";

  // focus node for input
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = DeviceDetect().getDeviceType();

    return Scaffold(
      // resolves the renderflex overflow issue
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: isTablet ? 600 : double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    top: 24,
                  ),
                  child: const Text(
                    "Welcome User \nLogin to your account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email@example.com",
                      onChanged: (value) {
                        _loginEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password",
                      onChanged: (value) {
                        _loginPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                    ),
                    CustomBtn(
                      dText: "Login",
                      onPressed: () {
                        // _alertDialogBuilder();
                        _submitForm();
                        /*setState(() {
                          _registerFormLoading = true;
                        });*/
                        print("clicked the Login Btn");

                      },
                      isLoading: _loginFormLoading,

                      outlineBtn: false,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    // top: 6,
                    bottom: 16,
                  ),
                  child: CustomBtn(
                    dText: "Create New Account",
                    onPressed: () {
                      // WidgetsBinding.instance!.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()
                        ),
                      );
                      // });
                      print ("clicked the create act btn");
                    },
                    outlineBtn: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
