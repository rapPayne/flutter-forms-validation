import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Map<String, String> _loginObject = Map<String, String>();
  String _pass1; // Your new password
  bool _agree = false; // Do you agree to terms and conditions?
  // TODO 2: Add a GlobalKey

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prestige Worldwide Registration")),
      // TODO 1: Wrap the body in a Form widget
      body: Container(
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _doRegister,
      ),
    );
  }

  Widget get _buildEmailField {
    return TextField(
      // TODO 4: Change to a TextFormField
      decoration: InputDecoration(labelText: "Email"),
      // TODO 5: Add onSaved and validator methods
      // TODO 9: Add autofocus
      // TODO 10: Add a focusNode
    );
  }

  Widget get _buildPasswordField {
    return TextField(
      // TODO 4: Change to a TextFormField
      decoration: InputDecoration(labelText: "Password"),
      obscureText: true,
      onChanged: (String val) => setState(() => _pass1 = val),
      // TODO 6: Add onSaved and validator methods to the password field
    );
  }

  Widget get _buildPasswordConfirmationField {
    return TextField(
      // TODO 4: Change to a TextFormField
      decoration: InputDecoration(labelText: "Password (again)"),
      obscureText: true,
      // TODO 7: Validate the password confirmation here
    );
  }

  Widget get _buildAgreeToTermsField {
    // TODO 8: Wrap the Column with a FormField<bool>
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Checkbox(
              value: _agree,
              onChanged: (bool val) => setState(() {
                _agree = val;
              }),
            ),
            const Text("I agree to the terms."),
          ],
        ),
      ],
    );
  }

  void _doRegister() {
    // TODO 3: Add validation and saving here
    print("""
    The user has registered with an email address of '${_loginObject['email']}' 
    and a password of '${_loginObject['password']}'
    """);
  }
}
