import 'package:flutter/material.dart';

enum LoginState { normal, loading }

typedef LoginActionCallback = void Function(
    String name, String email, String password);

class LoginPage extends StatefulWidget {
  final LoginState state;
  final LoginActionCallback onLoginCallback;
  final LoginActionCallback onRegisterCallback;

  LoginPage(
      {Key key, this.state, this.onLoginCallback, this.onRegisterCallback})
      : super(key: key);

  @override
  LoginPageState createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController(text: '');

  final TextEditingController _emailController =
      TextEditingController(text: '');

  final TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return loginPage();
  }

  Widget loginPage() {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView(
        padding: const EdgeInsets.only(
            left: 30.0, right: 30.0, top: 60.0, bottom: 0.0),
        children: [
          nameTextField(),
          SizedBox(height: 20.0),
          loginTextField(),
          SizedBox(height: 20.0),
          passwordTextField(),
          SizedBox(height: 40.0),
          this.widget.state == LoginState.normal
              ? actionButtons()
              : circularProgress(),
        ],
      ),
    );
  }

  Widget actionButtons() {
    return Column(
      children: <Widget>[
        loginButton(),
        registerButton(),
      ],
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Theme.of(context).primaryColor,
          child: Text(
            'Entrar',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 17.0,
                fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            this.widget.onLoginCallback(_nameController.text,
                _emailController.text, _passwordController.text);
          },
        ),
      ),
    );
  }

  Widget registerButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            'Cadastrar',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 17.0,
                fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            this.widget.onRegisterCallback(_nameController.text,
                _emailController.text, _passwordController.text);
          },
        ),
      ),
    );
  }

  Widget nameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextField(
          keyboardType: TextInputType.text,
          controller: _nameController,
          style: TextStyle(color: Theme.of(context).primaryColor),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: 'Nome',
          ),
        ),
      ],
    );
  }

  Widget loginTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          style: TextStyle(color: Theme.of(context).primaryColor),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'Email',
          ),
        ),
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: TextStyle(color: Theme.of(context).primaryColor),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            labelText: 'Senha',
          ),
        ),
      ],
    );
  }

  Widget circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
