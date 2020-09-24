import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Map<String, String> _loginObject = Map<String, String>();
  String _pass1; // Your new password
  bool _agree = false; // Do you agree to terms and conditions?
  bool _autovalidate =
      false; // Should the form validate after every user action?
  final FocusNode _emailFocusNode = FocusNode();
  // TODO 2: Add a GlobalKey
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prestige Worldwide Registration")),
      // TODO 1: Wrap the body in a Form widget
      body: Form(
        // <-- Add this widget. (Don't forget to close it!)
        autovalidate: _autovalidate, // <-- Add this line
        key: _key, // <-- Add this line
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              _buildEmailField,
              _buildPasswordField,
              _buildPasswordConfirmationField,
              _buildAgreeToTermsField,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _doRegister,
      ),
    );
  }

  Widget get _buildEmailField {
    return TextFormField(
      // TODO 4: Change to a TextFormField
      decoration: InputDecoration(labelText: "Email"),
      // TODO 5: Add onSaved and validator methods
      onSaved: (String val) => _loginObject['email'] = val,
      validator: _validateEmail,
      // TODO 9: Add autofocus
      autofocus: true,
      // TODO 10: Add a focusNode
      focusNode: _emailFocusNode,
    );
  }

  Widget get _buildPasswordField {
    return TextFormField(
      // TODO 4: Change to a TextFormField
      decoration: InputDecoration(labelText: "Password"),
      obscureText: true,
      onChanged: (String val) => setState(() => _pass1 = val),
      // TODO 6: Add onSaved and validator methods to the password field
      onSaved: (String val) => _loginObject['password'] = val,
      validator: _validatePassword,
    );
  }

  Widget get _buildPasswordConfirmationField {
    return TextFormField(
      // TODO 4: Change to a TextFormField
      decoration: InputDecoration(labelText: "Password (again)"),
      obscureText: true,
      // TODO 7: Validate the password confirmation here
      validator: _validatePasswordConfirmation,
    );
  }

  Widget get _buildAgreeToTermsField {
    // TODO 8: Wrap the Column with a FormField<bool>
    return FormField<bool>(
      // 1
      initialValue: _agree,
      builder: (FormFieldState<bool> state) {
        // 2
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  // 3
                  value: state.value,
                  onChanged: (bool val) => setState(() {
                    // 4
                    _agree = val;
                    // 5
                    state.didChange(val);
                  }),
                ),
                const Text("I agree to the terms."),
              ],
            ),
            // 6
            state.errorText == null
                ? Text("")
                : Text(state.errorText, style: TextStyle(color: Colors.red)),
          ],
        );
      },
      // 7
      validator: (val) => _validateTerms(_agree),
    );
  }

  // Valid if we get a well-formed and non-empty email address
  String _validateEmail(String email) {
    // 1
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    // Add the following line to set focus to the email field
    if (email.isEmpty || !regex.hasMatch(email)) _emailFocusNode.requestFocus();
    // 2
    if (email.isEmpty)
      return 'We need an email address';
    else if (!regex.hasMatch(email))
      // 3
      return "That doesn't look like an email address";
    else
      // 4
      return null;
  }

  String _validatePassword(String pass1) {
    RegExp hasUpper = RegExp(r'[A-Z]');
    RegExp hasLower = RegExp(r'[a-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasPunct = RegExp(r'[_!@#\$&*~-]');
    if (!RegExp(r'.{8,}').hasMatch(pass1))
      return 'Passwords must have at least 8 characters';
    if (!hasUpper.hasMatch(pass1))
      return 'Passwords must have at least one uppercase character';
    if (!hasLower.hasMatch(pass1))
      return 'Passwords must have at least one lowercase character';
    if (!hasDigit.hasMatch(pass1))
      return 'Passwords must have at least one number';
    if (!hasPunct.hasMatch(pass1))
      return 'Passwords need at least one special character like !@#\$&*~-';
    return null;
  }

  String _validatePasswordConfirmation(String pass2) {
    return (pass2 == _pass1) ? null : "The two passwords must match";
    // Note that _pass1 is populated when a password is entered
  }

  String _validateTerms(bool agree) {
    return agree ? null : "You must agree before proceeding";
    // It's invalid if the user hasn't opted in by checking the box
  }

  void _doRegister() {
    // After the first attempt to save, turn on autovalidate to give quicker feedback to the user
    setState(() => _autovalidate = true); // <-- Add this line
    // TODO 3: Add validation and saving here
    if (_key.currentState.validate()) {
      // Commit the field values to their variables
      _key.currentState.save();
      print("""
      The user has registered with an email address of '${_loginObject['email']}' 
      and a password of '${_loginObject['password']}'
      """);
    }
  }
}
