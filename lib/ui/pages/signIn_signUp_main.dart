part of 'pages.dart';

class SignInSignUpPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInSignUpPage> {
  // Size layar
  double get maxWidht => MediaQuery.of(context).size.width;
  double get maxHeight => MediaQuery.of(context).size.height;

  // Animasi
  bool isSignIn = true;
  bool isLoading = false;

  // Text Field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              ///NOTE: BACKGROUND
              SlideDown(
                0.5,
                ClipPath(
                  clipper: CustomClipPath1(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            mainColor,
                          ],
                          stops: [
                            0.0,
                            1.0
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          tileMode: TileMode.repeated),
                    ),
                  ),
                ),
              ),
              (!isSignIn)
                  ? SignUp(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController,
                      nameController: nameController,
                    )
                  : SignIn(
                      signIn: signIn,
                      signUp: signUp,
                      emailController: emailController,
                      passwordController: passwordController),
              (isLoading)
                  ? Container(
                      height: maxHeight,
                      width: maxWidht,
                      alignment: Alignment.center,
                      color: Colors.black.withOpacity(0.3),
                      child: SizedBox(child: CircularProgressIndicator()))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (isSignIn) {
      if (emailController.text.length > 0 &&
          passwordController.text.length > 0) {
        setState(() {
          isLoading = true;
        });
        SignInSignUpResult _result = await AuthServices.signIn(
            emailController.text, passwordController.text);

        if (_result.message != null) {
          warningError(context, _result.message);
          setState(() {
            isLoading = false;
          });
        }
      } else {
        warningError(context, 'Input field must not be empty');
      }
    } else {
      setState(() {
        isSignIn = true;
      });
      resetTextField();
    }
  }

  void signUp() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!isSignIn) {
      if (emailController.text.length > 0 &&
          passwordController.text.length > 0 &&
          nameController.text.length > 0) {
        setState(() {
          isLoading = true;
        });
        SignInSignUpResult _result = await AuthServices.signUp(
          emailController.text,
          passwordController.text,
          nameController.text,
          '',
        );
        if (_result.message != null) {
          warningError(context, _result.message);
          setState(() {
            isLoading = false;
          });
        }
      } else {
        warningError(context, 'Input field must not be empty');
      }
    } else {
      setState(() {
        isSignIn = false;
      });
      resetTextField();
    }
  }

  void resetTextField() {
    nameController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
  }

  Text heading(String text) {
    return Text(
      text,
      style: blackTextFont.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
    );
  }
}