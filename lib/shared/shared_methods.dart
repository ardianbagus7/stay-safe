part of 'shared.dart';

Future<File> imagePicker(ImageSource source) async {
  try {
    final picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: source, maxHeight: 1000, maxWidth: 1000);
    File image = File(pickedFile.path);
    return image;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String> uploadImage(File image) async {
  try {
    String fileName = basename(image.path);

    StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask task = ref.putFile(image);
    StorageTaskSnapshot snapshot = await task.onComplete;

    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    print(e);
    return null;
  }
}

/// NOTE: HAVERSINE FORMULA
double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

// SEARCH
setSearchParam(String caseNumber) {
  List<String> caseSearchList = List();
  String temp = "";
  for (int i = 0; i < caseNumber.length; i++) {
    temp = temp + caseNumber[i];
    caseSearchList.add(temp);
  }
  return caseSearchList;
}

// MARKER BITMAP
Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}
