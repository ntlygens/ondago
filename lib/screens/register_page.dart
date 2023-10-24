import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ondago/constants.dart';
import 'package:ondago/widgets/custom_input.dart';
import 'package:ondago/widgets/custom_btn.dart';

class RegisterPage extends StatefulWidget {

  // const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // alert dialog for errors
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
  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registeredEmail,
          password: _registeredPassowrd);
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

  // submit form
  void _submitForm() async {
    // set the form to loading state
    setState(() {
      _registerFormLoading = true;
    });

    // run the create account method
    String? createAccountFeedback = await _createAccount();

    // if string is not null error pops up
    if (createAccountFeedback != null) {
      _alertDialogBuilder(createAccountFeedback);

      // set the form to regular state: not loading
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // string is null, user is logged in
      Navigator.pop(context);
    }
  }

  bool _registerFormLoading = false;

  // core input field values
  String _registeredEmail = "";
  String _registeredPassowrd = "";

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: const Text(
                  "Create a New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "youremail@example.com",
                    onChanged: (value) {
                      _registeredEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "yourpassword",
                    onChanged: (value) {
                      _registeredPassowrd = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    dText: "Create Account",
                    onPressed: () {
                      // _alertDialogBuilder();
                      _submitForm();
                      /*setState(() {
                        _registerFormLoading = true;
                      });*/
                      print("clicked the Register Btn");

                    },
                    isLoading: _registerFormLoading,

                    outlineBtn: false,
                  ),
                ],
              ),
              Padding(
                padding:  const EdgeInsets.only(
                  bottom: 16,
                ),
                child: CustomBtn(
                  dText: "Back To Login",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
