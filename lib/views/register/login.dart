import 'package:flutter/material.dart';
import 'package:ninjain/models/cart_model.dart';
import 'package:ninjain/models/product_model.dart';
import 'package:ninjain/models/user_model.dart';
import 'package:ninjain/providers/cart_data.dart';
import 'package:ninjain/repositories/cart_repository.dart';
import 'package:ninjain/repositories/product_repository.dart';
import 'package:ninjain/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import '../../providers/user_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSubmitPressed = true;
  bool _obscurePassword = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Users) {
      _emailController.text = arguments.email!;
      _passwordController.text = arguments.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Users();
    final userData = Provider.of<UserData>(context);
    final cartData = Provider.of<CartData>(context);

    final CartRepository cartRepo = CartRepository();
    final UserRepository userRepo = UserRepository();
    final ProductRepository prodRepo = ProductRepository();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                'Ninja-In',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: _isSubmitPressed
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    validator: (value) {
                      RegExp emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (value == null) {
                        return 'email is required';
                      } else if (value.length < 10) {
                        return 'email must be more than 10 char';
                      } else if (!value.contains('@')) {
                        return 'email must contain @';
                      } else if (!emailRegex.hasMatch(value)) {
                        return 'invalid email';
                      }
                      return null;
                    },
                    maxLength: 30,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    obscureText: _obscurePassword,
                    controller: _passwordController,
                    autovalidateMode: _isSubmitPressed
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'password is required';
                      } else if (value.length < 3) {
                        return 'password must be more than 3 char';
                      } else {
                        return null;
                      }
                    },
                    maxLength: 20,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: _isLoading
                      ? Visibility(
                          visible: _isLoading,
                          child: CircularProgressIndicator(),
                        )
                      : TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColorDark,
                            backgroundColor: Theme.of(context).primaryColor,
                            minimumSize: Size(
                              MediaQuery.of(context).size.width,
                              50,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                                _isSubmitPressed = true;
                              });
                              user.email = _emailController.text;
                              user.password = _passwordController.text;
                              Users apiUser = await userRepo.login(user);
                              if (apiUser.name != null) {
                                List<Cart> carts =
                                    await cartRepo.getCarts(apiUser.id!);
                                userData.setUser(apiUser);
                                cartData.setCart(carts);
                                for (var cart in carts) {
                                  final Product prod =
                                      await prodRepo.getProdById(cart.prod_id!);
                                  cartData.addProd(prod);
                                }
                                Navigator.of(context).pushReplacementNamed('/');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Invaild email or password"),
                                    backgroundColor: Colors.redAccent,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                              setState(() {
                                _isLoading = false;
                                _isSubmitPressed = true;
                              });
                            }
                          },
                          child: Text('Submit'),
                        ),
                ),
                const Text(
                  'Didn\'t have an account?',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  child: const Text(
                    'sign up',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
