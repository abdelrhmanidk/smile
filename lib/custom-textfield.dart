import 'package:flutter/material.dart';
import 'package:smile/pages/Constants.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    required this.controller,
    this.isPasswordVisible = false,
    this.togglePasswordVisibility,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: kSecondaryColor, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        validator: validator,
        
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: kBackgroundColorSecondary),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: kBackgroundColorSecondary,
                  ),
                  onPressed: togglePasswordVisibility,
                )
              : null,

                      //  contentPadding: const EdgeInsets.only(left: 10), // Padding inside field
 
        ),
      ),
    );
  }
}
