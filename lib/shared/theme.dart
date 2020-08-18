part of 'shared.dart';

const double defaultMargin = 24;

// Color mainColor = Color(0xFF503E9D);
// Color mainColor = Color(0xFF162A49);
Color mainColor = Color(0xFF006BFF);
Color accentColor1 = Color(0xFF2C1F63);
Color accentColor2 = Color(0xFFFBD460);
Color accentColor3 = Color(0xFFADADAD);
Color accentColor4 = Color(0xFFF7F7F7); 
Color accentColor5 = Color(0xFFE0DEDF);

EdgeInsets mainPadding = EdgeInsets.symmetric(horizontal: 16);
EdgeInsets headerPadding = EdgeInsets.symmetric(horizontal: 16,vertical: 10);

TextStyle blackTextFont = GoogleFonts.poppins().copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.poppins().copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextFont = GoogleFonts.poppins().copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.poppins().copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont = GoogleFonts.openSans().copyWith(color: Colors.white);
TextStyle blackNumberFont = GoogleFonts.openSans().copyWith(color: Colors.black);
TextStyle yellowNumberFont = GoogleFonts.openSans().copyWith(color: accentColor2);
