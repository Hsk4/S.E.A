import 'package:flutter/material.dart';
import 'package:mobile/core/constants/routes.dart';
import 'package:mobile/core/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    final String input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Please enter your username';
    } else if (input.length < 3) {
      return 'Username must be at least 3 characters long';
    } else if (input.length > 50) {
      return 'Username cannot exceed 50 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final String input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(input)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    final String input = value ?? '';
    if (input.isEmpty) {
      return 'Please enter your password';
    } else if (input.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (input.length > 128) {
      return 'Password cannot exceed 128 characters';
    }
    return null;
  }

  Future<void> _onSignUp() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign up successful')),
    );
  }

  Future<void> _onGoogleSignUp() async {
    setState(() {
      _isLoading = true;
    });

    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google Sign up disabled in mock')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Sign Up',
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: AppCard(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      controller: _usernameController,
                      label: 'Username',
                      hintText: 'johndoe',
                      keyboardType: TextInputType.name,
                      validator: _validateUsername,
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 24),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Column(
                        children: [
                          AppPrimaryButton(
                            label: 'Sign up',
                            onPressed: _onSignUp,
                            isExpanded: true,
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text('OR'),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: _onGoogleSignUp,
                            icon: const Icon(Icons.account_circle),
                            label: const Text('Sign up with Google'),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                         Navigator.of(context).pushReplacementNamed(AppRoutes.authSignIn);
                      },
                      child: const Text('Already have an account? Sign in'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
