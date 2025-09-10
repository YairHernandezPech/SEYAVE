import 'package:flutter/material.dart';
import 'package:seyave/Home/PageSelected.dart';
import 'package:seyave/Home/Register.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color.fromARGB(255, 247, 40, 25).withOpacity(0.1),
                  const Color.fromARGB(255, 247, 40, 25).withOpacity(0.5),
                  const Color.fromARGB(255, 247, 40, 25),
                  const Color.fromARGB(255, 247, 40, 25),
                ],
                stops: const [0.1, 0.4, 0.5, 1.0],
              ),
            ),
          ),
          Center(
            child: Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seguridad en tus ventas, más rápido, más ágil y más útil...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/logo.png',
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'SEYAVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Login Form
                      Container(
                        width: 350,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Usuario',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Contraseña',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {

                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PageSelected(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 247, 40, 25),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>const CreateAccountPage(),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: const Text(
                                  'Crear cuenta',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}