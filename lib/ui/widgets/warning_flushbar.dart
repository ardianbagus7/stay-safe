part of 'widgets.dart';

  Flushbar warningError(BuildContext context,String text) {
    return Flushbar(
      duration: Duration(milliseconds: 2000),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Color(0xFFFF5C83),
      message: text,
    )..show(context);
  }