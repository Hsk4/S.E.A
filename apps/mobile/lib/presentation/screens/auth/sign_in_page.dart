import 'package:flutter/material.dart';
import 'package:mobile/core/constants/routes.dart';
import 'package:mobile/core/widgets/widgets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  // state variables 
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false ; 
  

  @override
  // dispose the controllers
  void dispose (){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// validations functions for email and password

   // validation email function 

  String? _validateEmail(String? value) {
    final String input = value?.trim() ?? '';
    if(input.isEmpty) {
      return 'Please enter your email';
    }

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(input)){
      return 'Please enter a valid email';
    }
    else {
      return null;
    }
  }

  // validation password function

  String? _validatePassword(String? value) {
     final String input = value ?? '';
     if(input.isEmpty ) {
      return 'Please enter your password';
     }
     else if(input.length < 8) {
      return 'Password must be at least 8 characters long';
     }
     else {
      return null;
     }
  }

  // Onsign function 

  Future<void> _onSignIn() async {
    
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }


    setState(() {
      _isloading = true;
          
    });

    await Future<void>.delayed(const Duration(seconds: 1));

    if(!mounted){
      return;
    }

    setState(
      (){
        _isloading = false;
      }
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign in successful'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Sign In', 
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),

          child: AppCard(
            child: Form(
              key: _formKey,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'you@example.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),

                  const SizedBox(height: 16),

                  AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: '********',
                    obscureText: true,
                    validator: _validatePassword,
                  ),

                  const SizedBox(height: 16),

                  _isloading
                     ? const Center(child: CircularProgressIndicator(),)
                     : AppPrimaryButton(
                      label: 'Sign in', 
                      onPressed: _onSignIn,
                      isExpanded: true,  
                  ),

                  const SizedBox(height: 8),

                  TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(AppRoutes.authSignUp);
                  }, 
                  child: const Text('Create an account.'))

                ],
              ),
              )
            
          ),
        ),
      )
      
    );
  }
}