part of 'widgets.dart';

class CachedImage extends StatelessWidget {
  final String url;
  CachedImage(this.url);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => Container(color: Colors.grey.withOpacity(0.5), child: Center(child: Icon(Icons.image, color: Colors.white))),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
