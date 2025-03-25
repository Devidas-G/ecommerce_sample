import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../auth_provider.dart';
import '../data/models/user.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  late AuthProvider authProvider;

  // Add TextEditingControllers for all fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: false,
                expandedHeight: 200.0,
                backgroundColor: Colors.red,
                flexibleSpace: FlexibleSpaceBar(
                  background: SizedBox(
                    width: size.width * 0.3,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
            ],
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create a Account", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Full Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _fullNameController, // Use unique controller
                    decoration: InputDecoration(
                      hintText: 'Enter Full Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Phone Number",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ), // Make text bold
                      ),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber); // Access the full phone number
                    },
                    onInputValidated: (bool value) {
                      print("Is valid: $value"); // Log validation status
                    },
                    selectorConfig: SelectorConfig(
                      trailingSpace: false,
                      selectorType:
                          PhoneInputSelectorType
                              .DROPDOWN, // Use dropdown for country code
                      setSelectorButtonAsPrefixIcon:
                          true, // Show country code as prefix inside the TextField
                      showFlags: false, // Show country flags in the dropdown
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: _phoneController,
                    formatInput: true,
                    keyboardType: TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    inputDecoration: InputDecoration(
                      hintText: 'Enter Phone Number', // Match hint text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Match border radius
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Match border radius for enabled state
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ), // Match border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Match border radius for focused state
                      ),
                    ),
                    onSaved: (PhoneNumber number) {
                      print('On Saved: $number');
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      }
                      return null; // Add more validation if needed
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController, // Use unique controller
                    decoration: InputDecoration(
                      hintText: 'Enter User Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      // Basic email validation using a regex
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController, // Use unique controller
                    decoration: InputDecoration(
                      hintText: 'Enter your Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "User Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _usernameController, // Use unique controller
                    decoration: InputDecoration(
                      hintText: 'Enter User Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your User Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(" *", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController, // Use unique controller
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters long";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Handle signup using the controllers
                        if (_formKey.currentState!.validate()) {
                          final user = User(
                            id: 0,
                            fullName: _fullNameController.text,
                            phoneNumber: _phoneController.text,
                            email: _emailController.text,
                            address: _addressController.text,
                            username: _usernameController.text,
                            password: _passwordController.text,
                          );

                          // Call signUp method from AuthProvider
                          bool success = await authProvider.signUp(user);

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Signup and Login Successful!'),
                              ),
                            );
                            // Navigate to the next screen (e.g., home screen)
                            // e.g., Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Api does not support user creation, use provided credentials',
                                ),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Sign Up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Have an Account?"),
                      TextButton(
                        onPressed: () {
                          authProvider.switchAuthPage();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
