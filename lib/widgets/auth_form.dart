import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../utils/auth_exception.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Map<String, String> _authData = {
    'matricula': '',
    'password': '',
  };

  // Fazendo animações na mudança de tamanho do formulário
  AnimationController? _controller;
  // ignore: unused_field
  Animation<double>? _opacityAnimation;
  // ignore: unused_field
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    _opacityAnimation = Tween(
      begin: -1.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.slowMiddle,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInExpo,
      ),
    );

    // _heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text('Ocorreu um erro'),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar'),
              ),
            ],
          )),
    );
  }

  Future<void> _submit() async {
    //Inicia o loading.
    setState(() => _isLoading = true);

    Auth auth = Provider.of(context, listen: false);
    _formKey.currentState?.save();

    try {
      // Efetuar login salvando os dados dentro da classe auth.

      await auth.login(
        _authData['matricula']!,
        _authData['password']!,
      );
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        //height: _isLogin() ? 310 : 400,
        padding: const EdgeInsets.all(6),

        // height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
        width: deviceSize.width * 0.70,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 12),
                decoration: const InputDecoration(labelText: 'Matricula'),
                keyboardType: TextInputType.number,
                onSaved: (matricula) =>
                    _authData['matricula'] = matricula ?? '',
              ),

              TextFormField(
                style: TextStyle(fontSize: 12),
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 5) {
                    return 'Informe uma senha válida';
                  } else {
                    return null;
                  }
                },
              ),

              SizedBox(height: 20),
              if (_isLoading == true)
                CircularProgressIndicator(
                  color: Colors.indigo.shade900,
                  strokeWidth: 2,
                )
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(90, 16),
                    primary: Colors.indigo.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: 30,
                    //   vertical: 20,
                    // ),
                  ),
                ),
              // Spacer(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
