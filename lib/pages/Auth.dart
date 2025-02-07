
import 'package:smile/Routes/app-routes.dart';
import 'package:smile/widgets/custom-textfield.dart';
import 'package:smile/pages/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isRegisterMode = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final _authkey = GlobalKey<FormState>();

  // Form controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Method to handle forgot password
  Future<void> _handleForgotPassword() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link sent to your email'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '  Email is required.';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return '  Enter a valid email address.';
    }
    return null;
  }

  String? validatePassword(String? value, bool isRegistering) {
    if (value == null || value.trim().isEmpty) {
      return '  Password is required.';
    }
    
    // Only apply strict password rules during registration
    if (isRegistering) {
      if (value.length < 8) {
        return '  Password must be at least 8 characters long.';
      }
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return '  Password must contain at least one uppercase letter.';
      }
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return '  Password must contain at least one lowercase letter.';
      }
      // if (!RegExp(r'[0-9]').hasMatch(value)) {
      //   return '  Password must contain at least one number.';
      // }
      // if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      //   return '  Password must contain at least one special character.';
      // }
    }
    
    return null;
  }

  String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return '  Confirm Password is required.';
    }
    if (value != originalPassword) {
      return '  Passwords do not match.';
    }
    return null;
  }

  // Check if user has filled the form
  // Future<bool> _hasUserFilledForm(String userId) async {
  //   try {
  //     final userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('userId', isEqualTo: userId)
  //         .get();
      
  //     return userDoc.docs.isNotEmpty;
  //   } catch (e) {
  //     print('Error checking user form status: $e');
  //     return false;
  //   }
  // }

  // Navigate based on form status
  // Future<void> _handlePostAuthNavigation(User user) async {
  //   final hasFilledForm = await _hasUserFilledForm(user.uid);
    
  //   if (hasFilledForm) {
  //     Get.offAllNamed(AppRoutes.homeScreen);
  //   } else {
  //     Get.offAllNamed(AppRoutes.formscreen);
  //   }
  // }

  // Email/Password Sign Up
  Future<void> registerWithEmail() async {
    setState(() => _isLoading = true);
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Create user document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
        'createdAt': FieldValue.serverTimestamp(),
        'skills': [], // Initialize empty skills array
      });

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      setState(() => _isLoading = false);
      
      // Show success message and instructions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful! Please check your email to verify your account.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );

      // Toggle back to login mode
      setState(() {
        _isRegisterMode = false;
      });

    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      String errorMessage = 'Registration failed';
      
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Email/Password Login
  Future<void> loginWithEmail() async {
    setState(() => _isLoading = true);
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Check if email is verified
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Text('Please verify your email before logging in.'),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await userCredential.user?.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Verification email sent! Please check your inbox.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error sending verification email. Please try again later.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Resend',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 8),
          ),
        );
        return;
      }

      setState(() => _isLoading = false);
      Get.offAllNamed(AppRoutes.homeScreen);
      
      if (userCredential.user != null) {
       
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'Login failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Google Sign In
  Future<void> signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Check if this is a new user
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Create user document in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'displayName': userCredential.user!.displayName,
          'photoURL': userCredential.user!.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
          'skills': [], // Initialize empty skills array
        });
      }

      setState(() => _isLoading = false);
      // await _handlePostAuthNavigation(userCredential.user!);
Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing in with Google: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorSecondary,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _authkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    Text(
                      'Go ahead and set up your account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Sign in/up to enjoy the best career experience',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Container(

                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 200,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      height: 70,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(40),
                        color: kSecondaryColor,
                      ),
                      child: Stack(
                        children: [
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            alignment: _isRegisterMode
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              width: 180,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: kBackgroundColorPrimary,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isRegisterMode = true;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.poppins(
                                        color: _isRegisterMode
                                            ? Colors.black
                                            : Colors.grey.shade500,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isRegisterMode = false;
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.poppins(
                                        color: !_isRegisterMode
                                            ? Colors.black
                                            : Colors.grey.shade500,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        _isRegisterMode ? buildRegisterForm() : buildLoginForm(),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        if (_authkey.currentState?.validate() ?? false) {
                          // Proceed with login if the form is valid
                          _isRegisterMode
                              ? registerWithEmail()
                              : loginWithEmail();
                        } else {
                          // Validation failed
                          Get.snackbar(
                            'Error',
                            'Enter a valid email & password',
                            backgroundColor: Colors.red.shade900,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: Container(
                        height: 57.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            _isRegisterMode ? 'Register' : 'Login',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Divider(
                              color: Colors.black,
                              thickness: 1.5,
                            ),
                          ),
                        ),
                        const Text(
                          'or continue with',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Divider(
                              color: Colors.black,
                              thickness: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        signInWithGoogle();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 80),
                        height: 57.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/google.png',
                                height: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Google',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return Column(
      children: [
        CustomTextField(
          labelText: 'Email address',
          icon: Icons.email,
          controller: _emailController,
          validator: validateEmail,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          labelText: 'Password',
          icon: Icons.lock,
          isPassword: true,
          controller: _passwordController,
          isPasswordVisible: _isPasswordVisible,
          togglePasswordVisibility: _togglePasswordVisibility,
          validator: (value) => validatePassword(value, false), // Pass false for login mode
        ),
        SizedBox(height: 10),
        if (!_isRegisterMode) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: _handleForgotPassword,
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget buildRegisterForm() {
    return Column(
      children: [
        CustomTextField(
          labelText: 'Email address',
          icon: Icons.email,
          controller: _emailController,
          validator: validateEmail,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          labelText: 'Password',
          icon: Icons.lock,
          isPassword: true,
          controller: _passwordController,
          isPasswordVisible: _isPasswordVisible,
          togglePasswordVisibility: _togglePasswordVisibility,
          validator: (value) => validatePassword(value, true), // Pass true for register mode
        ),
        const SizedBox(height: 20),
        CustomTextField(
          labelText: 'Confirm Password',
          icon: Icons.lock,
          isPassword: true,
          controller: _confirmPasswordController,
          isPasswordVisible: _isPasswordVisible,
          togglePasswordVisibility: _togglePasswordVisibility,
          validator: (value) => validateConfirmPassword(
            value,
            _passwordController.text.trim(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
