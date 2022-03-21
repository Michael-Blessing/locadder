import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locadder/Photo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locadder/Video.dart';
import 'dart:convert' show utf8;
import 'dart:typed_data' show Uint8List;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadText(String text, int postNumber, String type) async {
    List<int> encoded = utf8.encode(text);
    Uint8List data = Uint8List.fromList(encoded);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$type$postNumber.txt')
          .putData(data);
    } on firebase_core.FirebaseException catch (e) {}
  }

  Future<void> uploadText1(String text, int postNumber) async {
    List<int> encoded = utf8.encode(text);
    Uint8List data = Uint8List.fromList(encoded);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('text/$postNumber.txt')
          .putData(data);
    } on firebase_core.FirebaseException catch (e) {}
  }

  Future<int> fetchNumberOfPosts() async {
    final listRef = firebase_storage.FirebaseStorage.instance.ref('text/');
    final allResults = await listRef.listAll();
    return allResults.items.length;
  }
}

class HomePageWidget extends StatefulWidget {
  final CameraDescription firstCamera;
  HomePageWidget(this.firstCamera, {Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  TextEditingController textController1;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  bool _loadingButton4 = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Position currentPosition;
  dynamic lat;
  dynamic alt;
  String currentAddress;
  final Geolocator geolocator = Geolocator();
  int countOfPosts = 0;
  final Storage storage = Storage();

  @override
  void initState() {
    super.initState();
    storage.fetchNumberOfPosts().then((result) {
      setState(() {
        countOfPosts = result;
      });
    });
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      print("${place.locality}, ${place.postalCode}, ${place.country}");
      setState(() {
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  getAdress() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        lat = currentPosition.latitude;
        alt = currentPosition.altitude;
        textController1.text = currentAddress;
      });
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  uploadTextFrom() {
    String text1 = textController1.text;
    storage.uploadText(text1, countOfPosts, 'Addresse');
    String text2 = textController2.text;
    storage.uploadText(text2, countOfPosts, 'Addresse');
    storage.uploadText1(text2, countOfPosts);
    textController2.text = '';
    textController1.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        title: Text(
          'Location Adder',
          style: GoogleFonts.getFont(
            'Raleway',
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          clipBehavior: Clip.none,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: TextFormField(
                    controller: textController1,
                    decoration: InputDecoration(
                      hintText: 'Click on the Button to get your Location',
                      hintStyle: GoogleFonts.getFont(
                        'Raleway',
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9E9E9E),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9E9E9E),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEFEFEF),
                    ),
                    style: GoogleFonts.getFont(
                      'Raleway',
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(70, 10, 10, 10),
                  child: FFButtonWidget(
                    onPressed: () => getAdress(),
                    text: 'Get Current Position',
                    icon: FaIcon(
                      FontAwesomeIcons.locationArrow,
                      size: 16,
                    ),
                    options: FFButtonOptions(
                      width: 250,
                      height: 50,
                      color: Color(0xFF0305FE),
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 100,
                    ),
                    loading: _loadingButton4,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: TextFormField(
                    controller: textController2,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Description of Place',
                      hintStyle: GoogleFonts.getFont(
                        'Raleway',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9E9E9E),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF9E9E9E),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFEFEFEF),
                    ),
                    style: GoogleFonts.getFont(
                      'Raleway',
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 1, 0),
                      child: Text(
                        'Latitude',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(1, 10, 10, 10),
                          child: lat != null ? Text(lat.toString()) : Text('')),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(1, 0, 1, 0),
                      child: Text(
                        'Altitude',
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(1, 10, 20, 10),
                          child: alt != null ? Text(alt.toString()) : Text('')),
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TakePictureScreen(Camera: widget.firstCamera),
                            ),
                          );
                        },
                        text: '',
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 14,
                        ),
                        options: FFButtonOptions(
                          width: 50,
                          height: 50,
                          color: Color(0xFFDC0C0C),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 100,
                        ),
                        loading: _loadingButton1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {},
                        /*onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TakeAudioScreen()));
                          },*/
                        text: '',
                        icon: FaIcon(
                          FontAwesomeIcons.microphone,
                          size: 16,
                        ),
                        options: FFButtonOptions(
                          width: 50,
                          height: 50,
                          color: Color(0xFFDC0C0C),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 100,
                        ),
                        loading: _loadingButton2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoRecorderExample(),
                            ),
                          );
                        },
                        text: '',
                        icon: FaIcon(
                          FontAwesomeIcons.video,
                          size: 12,
                        ),
                        options: FFButtonOptions(
                          width: 50,
                          height: 50,
                          color: Color(0xFFDC0C0C),
                          textStyle: FlutterFlowTheme.subtitle2.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 100,
                        ),
                        loading: _loadingButton3,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FFButtonWidget(
                        onPressed: () => {},
                        text: 'Look at the posts',
                        icon: FaIcon(
                          FontAwesomeIcons.eye,
                          size: 16,
                        ),
                        options: FFButtonOptions(
                          width: 170,
                          height: 40,
                          color: Color(0xFF0305FE),
                          textStyle: GoogleFonts.getFont(
                            'Raleway',
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                        loading: _loadingButton4,
                      ),
                      FFButtonWidget(
                        onPressed: () {
                          setState(() {
                            uploadTextFrom();
                            countOfPosts = countOfPosts + 1;
                          });
                        },
                        text: 'Create',
                        icon: FaIcon(
                          FontAwesomeIcons.award,
                          size: 16,
                        ),
                        options: FFButtonOptions(
                          width: 170,
                          height: 40,
                          color: Color(0xFF0305FE),
                          textStyle: GoogleFonts.getFont(
                            'Raleway',
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
