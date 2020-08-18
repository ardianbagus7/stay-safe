part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(id: firebaseUser.uid));

        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(builder: (_, pageState) {
      if (pageState is OnSplashPage)
        return SplashPage();
      else if (pageState is OnLoginPage)
        return SignInSignUpPage();
      else if (pageState is OnMainPage && firebaseUser != null)
        return HomeWrapper(firebaseUser.uid);
      else
        return Scaffold(
          body: Container(
            color: accentColor4,
            alignment: Alignment.center,
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()),
          ),
        );
    });
  }
}
