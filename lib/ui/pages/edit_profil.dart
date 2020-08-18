part of 'pages.dart';

class EditProfil extends StatefulWidget {
  final User user;
  EditProfil(this.user);
  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  TextEditingController titleController = TextEditingController();
  File image;

  @override
  void initState() {
    super.initState();
    
    titleController = TextEditingController(text: widget.user.name);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor5,
      appBar: AppBar(
        backgroundColor: accentColor4,
        centerTitle: true,
        elevation: 0.5,
        brightness: Brightness.light,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Icon(Icons.arrow_back_ios, color: mainColor),
        ),
        title: Text(
          'Edit Profil',
          style: purpleTextFont.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                padding: headerPadding,
                color: accentColor4,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    InkWell(
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  color: Colors.grey.withOpacity(0.5),
                                  height: 200,
                                  width: 200,
                                  child: (image == null &&
                                          widget.user.profilePicture == "")
                                      ? Icon(Icons.add_a_photo,
                                          color: Colors.white, size: 40.0)
                                      : (image == null &&
                                              widget.user.profilePicture != "")
                                          ? FittedBox(
                                              fit: BoxFit.cover,
                                              child: CachedNetworkImage(
                                                  imageUrl: widget
                                                      .user.profilePicture),
                                            )
                                          : FittedBox(
                                              fit: BoxFit.cover,
                                              child: Image.file(image),
                                            ),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: mainColor,
                                  child: Icon(Icons.edit,
                                      color: Colors.white, size: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        final _imageNew =
                            await imagePicker(ImageSource.gallery);
                        setState(() {
                          if (_imageNew != null) image = _imageNew;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name',
                      style: blackTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: titleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 20),
                    (!isLoading)
                        ? InkWell(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (image != null) {
                                final String _url = await uploadImage(image);
                                final bool isOk = await UserServices.updateUser(
                                  widget.user.copyWith(
                                    name: titleController.text,
                                    profilePicture: _url,
                                  ),
                                );
                                if (isOk) Navigator.pop(context, true);
                              } else {
                                final bool isOk = await UserServices.updateUser(
                                  widget.user.copyWith(
                                    name: titleController.text,
                                    profilePicture: widget.user.profilePicture,
                                  ),
                                );
                                if (isOk) Navigator.pop(context, true);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: mainColor,
                                alignment: Alignment.center,
                                child: Text('Change',
                                    style: whiteTextFont.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                          )
                        : SizedBox(
                            child: Center(child: CircularProgressIndicator())),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
