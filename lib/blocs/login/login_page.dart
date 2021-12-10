part of 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Box<String> userCredentialsBox = Hive.box<String>(hiveBoxUserCredentials);

    //Set form values if present.
    if (userCredentialsBox.get('email') != null) {
      String email = userCredentialsBox.get('email')!;
      String password = userCredentialsBox.get('password')!;

      _emailController.text = email;
      _passwordController.text = password;
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.green,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.7)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 1]),
            ),
          ),
          SafeArea(
            child: Form(key: _formKey, child: Container()
                //  ListView(
                //   children: [
                //     const SizedBox(
                //       height: 100,
                //     ),
                //     BlocConsumer<LoginBloc, LoginState>(
                //         builder: (context, state) {
                //       if (state is LoadingState) {
                //         return const CircularProgressIndicator();
                //       }

                //       if (state is ErrorState) {
                //         final String errorMessage = state.error.message ??
                //             'Could not log in at this time.';

                //         return Center(
                //           child: Column(
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.all(20),
                //                 child: Text(
                //                   errorMessage,
                //                   textAlign: TextAlign.center,
                //                   style: const TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 21,
                //                       fontWeight: FontWeight.w300),
                //                 ),
                //               ),
                //               ElevatedButton(
                //                 style: ButtonStyle(
                //                   shape: MaterialStateProperty.all<
                //                       RoundedRectangleBorder>(
                //                     RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(8.0),
                //                     ),
                //                   ),
                //                 ),
                //                 child: const Text(
                //                   'Try Again?',
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //                 onPressed: () {
                //                   context.read<LoginBloc>().add(
                //                         TryAgainEvent(),
                //                       );
                //                 },
                //               ),
                //             ],
                //           ),
                //         );
                //       }

                //       if (state is InitialState) {
                //         bool passwordVisible = state.passwordVisible;
                //         bool rememberMe = state.rememberMe;

                //         return Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Column(
                //             children: [
                //               TextFormField(
                //                 autovalidateMode:
                //                     AutovalidateMode.onUserInteraction,
                //                 validator: locator<ValidationService>().email,
                //                 controller: _emailController,
                //                 style: const TextStyle(color: Colors.white),
                //                 decoration: const InputDecoration(
                //                     errorStyle: TextStyle(color: Colors.white),
                //                     prefixIcon: Icon(
                //                       Icons.alternate_email,
                //                       color: Colors.white,
                //                     ),
                //                     border: OutlineInputBorder(
                //                       // width: 0.0 produces a thin "hairline" border
                //                       borderRadius: BorderRadius.all(
                //                         Radius.circular(90.0),
                //                       ),
                //                       borderSide: BorderSide.none,

                //                       //borderSide: const BorderSide(),
                //                     ),
                //                     hintStyle: TextStyle(
                //                         color: Colors.white,
                //                         fontFamily: "WorkSansLight"),
                //                     filled: true,
                //                     fillColor: Colors.white24,
                //                     hintText: 'Email'),
                //               ),
                //               const SizedBox(height: 20),
                //               TextFormField(
                //                 autovalidateMode:
                //                     AutovalidateMode.onUserInteraction,
                //                 validator: locator<ValidationService>().password,
                //                 obscureText: !passwordVisible,
                //                 controller: _passwordController,
                //                 style: const TextStyle(color: Colors.white),
                //                 decoration: InputDecoration(
                //                     errorStyle:
                //                         const TextStyle(color: Colors.white),
                //                     prefixIcon: const Icon(
                //                       Icons.lock,
                //                       color: Colors.white,
                //                     ),
                //                     suffixIcon: IconButton(
                //                       icon: Icon(
                //                         passwordVisible
                //                             ? Icons.visibility
                //                             : Icons.visibility_off,
                //                         color: Colors.white,
                //                       ),
                //                       onPressed: () {
                //                         context
                //                             .read<LoginBloc>()
                //                             .add(UpdatePasswordVisibleEvent());
                //                       },
                //                     ),
                //                     border: const OutlineInputBorder(
                //                       // width: 0.0 produces a thin "hairline" border
                //                       borderRadius: BorderRadius.all(
                //                         Radius.circular(90.0),
                //                       ),
                //                       borderSide: BorderSide.none,
                //                     ),
                //                     hintStyle: const TextStyle(
                //                         color: Colors.white,
                //                         fontFamily: "WorkSansLight"),
                //                     filled: true,
                //                     fillColor: Colors.white24,
                //                     hintText: 'Password'),
                //               ),
                //               const SizedBox(
                //                 height: 40,
                //               ),
                //               Container(
                //                 color: Colors.white,
                //                 height: 50,
                //                 width: double.infinity,
                //                 child: CheckboxListTile(
                //                   title: const Text(
                //                     'Remember Me',
                //                   ),
                //                   value: rememberMe,
                //                   onChanged: (newValue) {
                //                     context.read<LoginBloc>().add(
                //                           UpdateRememberMeEvent(),
                //                         );
                //                   },
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 50,
                //               ),
                //               CustomButton(
                //                 buttonColor: Colors.red,
                //                 text: 'Login',
                //                 textColor: Colors.white,
                //                 onPressed: () async {
                //                   if (!_formKey.currentState!.validate()) return;

                //                   final String email = _emailController.text;
                //                   final String password =
                //                       _passwordController.text;

                //                   context.read<LoginBloc>().add(
                //                         SubmitEvent(
                //                           email: email,
                //                           password: password,
                //                         ),
                //                       );
                //                 },
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(20),
                //                 child: InkWell(
                //                   onTap: () {
                //                     Route route = MaterialPageRoute(
                //                       builder: (BuildContext context) =>
                //                           BlocProvider(
                //                         create: (BuildContext context) =>
                //                             SignUpBloc(),
                //                         child: const SignUpPage(),
                //                       ),
                //                     );
                //                     Navigator.push(context, route);
                //                   },
                //                   child: RichText(
                //                     textAlign: TextAlign.center,
                //                     text: const TextSpan(
                //                       style:
                //                           TextStyle(fontWeight: FontWeight.bold),
                //                       children: [
                //                         TextSpan(
                //                             text: 'New to Score Square?',
                //                             style: TextStyle(color: Colors.grey)),
                //                         TextSpan(text: ' Create an Account')
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Center(
                //                 child: InkWell(
                //                   child: Text(
                //                     'Forgot Password?',
                //                     style: TextStyle(
                //                       color: Colors.grey.shade100,
                //                       fontSize: 14,
                //                     ),
                //                   ),
                //                   onTap: () {
                //                     // Route route = MaterialPageRoute(
                //                     //   builder: (BuildContext context) =>
                //                     //       BlocProvider(
                //                     //     create: (BuildContext context) =>
                //                     //         FORGOT_PASSWORD_BP
                //                     //             .ForgotPasswordBloc()
                //                     //           ..add(
                //                     //             FORGOT_PASSWORD_BP
                //                     //                 .LoadPageEvent(),
                //                     //           ),
                //                     //     child: FORGOT_PASSWORD_BP
                //                     //         .ForgotPasswordPage(),
                //                     //   ),
                //                     // );
                //                     // Navigator.push(context, route);
                //                   },
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       }

                //       return Container();
                //     }, listener: (context, state) {
                //       if (state == SuccessState()) {
                //         //Navigator.of(context).popUntil((route) => route.isFirst);
                //       }
                //       if (state is ErrorState) {
                //         //todo: Report this sign in failure somewhere perhaps?
                //       }
                //     })
                //   ],
                // ),
                ),
          ),
        ],
      ),
    );
  }
}
