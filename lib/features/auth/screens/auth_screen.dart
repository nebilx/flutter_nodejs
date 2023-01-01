import 'package:flutter/material.dart';
import 'package:flutter_nodejs/common/widgets/custom_button.dart';
import 'package:flutter_nodejs/common/widgets/custom_textfield.dart';
import 'package:flutter_nodejs/constants/global_variable.dart';

enum Auth {signin, signup}

class AuthScreen extends StatefulWidget {
static const String routeName = '/auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth =Auth.signup;
  final _signUpFormkey = GlobalKey<FormState>();
    final _signInFormkey = GlobalKey<FormState>();

    final TextEditingController _emailController = TextEditingController();
        final TextEditingController _passwordController = TextEditingController();
            final TextEditingController _nameController = TextEditingController();

            @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GloalVariable.grayBackgroundColor,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            const Text('Welcome', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500 ),),

            ListTile(
              tileColor: _auth == Auth.signup ? GloalVariable.backgroundColor : GloalVariable.grayBackgroundColor,
              title: const Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold),),
              leading: Radio(activeColor: GloalVariable.secondaryColor, value: Auth.signup, groupValue: _auth, onChanged: (Auth? val){
                setState(() {
                  _auth =val!;
                });
              }),
            ),
if(_auth == Auth.signup)
Container(
  padding: const EdgeInsets.all(8),
  color: Colors.white,
  child:   Form(key: _signUpFormkey , child: Column(
  
  children: [
    CustomTextField(controller: _nameController, text: 'name'),
    const SizedBox(height: 10),
      CustomTextField(controller: _emailController, text: 'email'),
       const SizedBox(height: 10),
        CustomTextField(controller: _passwordController, text: 'password'),
         const SizedBox(height: 10),
  CustomButton(text: 'Sign Up', onTap: () {}),
    const SizedBox(height: 10),
  ],
  
  )),
),

             ListTile(
               tileColor: _auth == Auth.signin ? GloalVariable.backgroundColor : GloalVariable.grayBackgroundColor,
              title: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold),),
              leading: Radio(activeColor: GloalVariable.secondaryColor, value: Auth.signin, groupValue: _auth, onChanged: (Auth? val){
                setState(() {
                  _auth =val!;
                });
              }),
            ),
if(_auth == Auth.signin)
Container(
  padding: const EdgeInsets.all(8),
  color: Colors.white,
  child:   Form(key: _signUpFormkey , child: Column(
  
  children: [

      CustomTextField(controller: _emailController, text: 'email'),
       const SizedBox(height: 10),
        CustomTextField(controller: _passwordController, text: 'password'),
         const SizedBox(height: 10),
  CustomButton(text: 'Sign In', onTap: () {}),
    const SizedBox(height: 10),
  ],
  
  )),
),

          ],
        ),
      )) ,
    );
  }
}