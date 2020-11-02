import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:spotmelanoma/core/models/user.dart';
import 'package:tflite/tflite.dart';
import 'package:spotmelanoma/core/services/imageclassifier.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:spotmelanoma/core/services/classifiermeta.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart' as helpertf;
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import '../../core/viewmodels/CRUDModel.dart';
import '../../core/models/scanModel.dart';
import 'package:spotmelanoma/core/models/user.dart';

bool getresult = false;

class pick_image extends StatefulWidget {
  @override
  _pick_imageState createState() => _pick_imageState();
}

bool _formfilled = false;
bool imagepicked = false;
int flag = 100000;

class _pick_imageState extends State<pick_image> {
  bool isloading = true;
  File _image;
  String path = "";
  String imgString;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() {
      _formfilled = false;
      imagepicked = false;
    });
    _classifier3 = ClassifierMeta();
  }

  Widget Load() {
    return Column(
      children: [
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey[900]),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Tap On Show Results ",
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }

  getImagecamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
      _imageWidget = Image.file(
        _image,
      );
    });
  }

  Future getImagegallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      _imageWidget = Image.file(
        _image,
      );
    });
  }

  bool _selectedyes = false;

  ImageClassifier _classifier3;
  var logger = Logger();
  Image _imageWidget;
  img.Image fox;
  helpertf.Category category3;

  void _predict3() async {
    print("Prediction Running....");
    img.Image imageInput = img.decodeImage(_image.readAsBytesSync());
    var pred = _classifier3.predict(imageInput);
    setState(() {
      this.category3 = pred;
      isloading = false;
    });
  }

  Widget _getFAB() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: SpeedDial(
          elevation: 12,
          animatedIcon: AnimatedIcons.view_list,
          animatedIconTheme: IconThemeData(size: 22),
          backgroundColor: Colors.blueGrey[900],
          visible: true,
          curve: Curves.bounceIn,
          children: [
            // FAB 1
            SpeedDialChild(
                child: Icon(Icons.camera_alt),
                backgroundColor: Colors.blueGrey[900],
                onTap: getImagecamera,
                label: 'Camera',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.blueGrey[900]),
            // FAB 2
            SpeedDialChild(
                child: Icon(Icons.photo_size_select_actual),
                backgroundColor: Colors.blueGrey[900],
                onTap: getImagegallery,
                label: 'Gallery',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.blueGrey[900])
          ],
        ),
      ),
    );
  }

  Widget pickimagehere() {
    var scanProvider = Provider.of<CRUDModel>(context);
    var idh = Provider.of<User>(context).id;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          flexibleSpace: Container(),
          title: Text('Upload Image', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: _image == null
                      ? Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Select a clear picture of the affected area',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 350,
                                child: Image.file(_image, fit: BoxFit.fitWidth),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                isloading
                                    ? Load()
                                    : _selectedyes
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              category3.label != null
                                                  ? Column(
                                                      children: [
                                                        Text(
                                                          category3 != null
                                                              ? " " +
                                                                  category3
                                                                      .label
                                                              : 'Results Will Be Displayed Here....',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          category3 != null
                                                              ? 'Melanoma Confidence : ${category3.score.toStringAsFixed(3)}'
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    )
                                                  : Column
                                            ],
                                          )
                                        : Column,
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlineButton(
                                  splashColor: Colors.blueGrey[900],
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey[900]),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  highlightedBorderColor: Colors.blueGrey[900],
                                  child: Text("Show Results"),
                                  onPressed: () {
                                    setState(() {
                                      isloading = true;
                                      getresult = true;
                                      _selectedyes = true;
                                    });
                                    _predict3();
                                  },
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                OutlineButton(
                                  splashColor: Colors.blueGrey[900],
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey[900]),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  highlightedBorderColor: Colors.blueGrey[900],
                                  child: Text("Reset"),
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                      this.category3 = null;
                                      isloading = true;
                                      getresult = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            getresult
                                ? OutlineButton(
                                    splashColor: Colors.blueGrey[900],
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey[900]),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    highlightedBorderColor:
                                        Colors.blueGrey[900],
                                    child: Text("Save result"),
                                    onPressed: () async {
                                      getresult = false;
                                      double perc = (category3.score) * 100;
                                      String score = perc.toStringAsFixed(2);
                                      var now = new DateTime.now();
                                      var formatter =
                                          new DateFormat('yyyy-MM-dd');
                                      String formattedDate =
                                          formatter.format(now);
                                      await scanProvider.addScanResult(ScanModel(
                                          userId: idh.toString(),
                                          percentage: score,
                                          result: category3.label,
                                          scanDate: formattedDate));
                                      //Navigator.pop(context)
                                      setState(() {
                                        Navigator.pop(context);
                                        //Navigator.pushNamed(context, "/");
                                      });
                                    },
                                  )
                                : Container()
                          ],
                        )),
              SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
        floatingActionButton: _getFAB() // floatingActionButton: _getFAB()
        );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: pickimagehere(),
      ),
    );
  }
}
