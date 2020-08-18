part of 'widgets.dart';

class TextHeading extends StatelessWidget {
  final String text;
  TextHeading(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mainPadding,
      child: Container(
        margin: EdgeInsets.only(bottom: 10, top: 20),
        child: Text(
          text,
          style: blackTextFont.copyWith(
              fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class TextSubHeading extends StatelessWidget {
  final String text;
  TextSubHeading(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Text(
        text,
        style: blackTextFont.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
