part of 'widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    Key key,
    @required this.emailController,
    @required this.passwordController,
    @required this.signIn,
    @required this.signUp,
  }) : super(key: key);

  final Function signIn;
  final Function signUp;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: mainPadding,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(child: SizedBox(height: 20)),
          SlideUp(
            0.5,
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Welcome',
                style: blackTextFont.copyWith(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SlideUp(
            0.75,
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Back',
                style: blackTextFont.copyWith(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(child: SizedBox(height: 10)),
          FadeInLeft(
            1,
            TextField(
              keyboardType: TextInputType.text,
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.email, color: mainColor),
                filled: true,
                fillColor: accentColor4,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInRight(
            1,
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: blackTextFont.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(Icons.lock, color: mainColor),
                filled: true,
                fillColor: accentColor4,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(height: 10),
          FadeInUp(
            1,
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot password?',
                style: blackTextFont.copyWith(
                    color: mainColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 20),
          FadeInUp(
            1,
            InkWell(
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mainColor,
                ),
                child: Text(
                  'Sign in',
                  style: whiteTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                signIn();
              },
            ),
          ),
          FadeInUp(
            1.25,
            InkWell(
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Wrap(
                  children: <Widget>[
                    Text(
                      "Don't? have an account?  ",
                      style: whiteTextFont.copyWith(
                          color: mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),Text(
                      'Sign up',
                      style: whiteTextFont.copyWith(
                          color: mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              onTap: () {
                signUp();
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
