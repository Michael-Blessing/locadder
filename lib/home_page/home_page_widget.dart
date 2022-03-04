import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:geocode/geocode.dart';
import 'package:locadder/Photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locadder/Video.dart';

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
  bool _loadingButton5 = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Coordinates coordinates;
  GeoCode geoCode = GeoCode();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  Widget getLong() {
    if (this.coordinates != null) {
      var long = this.coordinates.longitude;
      return Text(long.toString());
    } else {
      return Text('bald');
    }
  }

  Widget getLat() {
    if (this.coordinates != null) {
      var long = this.coordinates.latitude;
      return Text(long.toString());
    } else {
      return Text('bald');
    }
  }

  search() async {
    try {
      Coordinates results = await geoCode.forwardGeocoding(
          address: textController1.text.toString());
      print(results);
      this.setState(() {
        this.coordinates = results;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.primaryColor,
          automaticallyImplyLeading: true,
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
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => setState(() {}),
                      controller: textController1,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Name of POI',
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
                        suffixIcon: textController1.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => textController1.clear(),
                                ),
                                child: Icon(
                                  Icons.clear,
                                  color: Color(0xFF757575),
                                  size: 22,
                                ),
                              )
                            : null,
                      ),
                      style: GoogleFonts.getFont(
                        'Raleway',
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.start,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'You need to set a name to the Location!';
                        }
                        if (val.length < 3) {
                          return 'You can\'t write  than 3 characters!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                        child: FFButtonWidget(
                          onPressed: /* () => FirebaseFirestore.instance
                              .collection('testing5')
                              .add(
                            {
                              'timestamp': Timestamp.fromDate(
                                DateTime.now(),
                              ),
                            },
                          ),*/
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TakePictureScreen(
                                    Camera: widget.firstCamera),
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
                          onPressed: /*() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TakeAudioScreen()));
                          },*/
                              () {},
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
                                    builder: (context) => VideoRecorderApp()));
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
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                    child: FFButtonWidget(
                      onPressed: () => search(),
                      text: 'Search',
                      options: FFButtonOptions(
                        width: 130,
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
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 1, 0),
                        child: Text(
                          'Lat',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(1, 10, 10, 10),
                            child: getLat()),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(1, 0, 1, 0),
                        child: Text(
                          'Long',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(1, 10, 20, 10),
                            child: getLong()),
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
                          /*async {
                            setState(() => _loadingButton4 = true);
                            try {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.topToBottom,
                                  duration: Duration(milliseconds: 300),
                                  reverseDuration: Duration(milliseconds: 300),
                                  child: HomePageWidget(),
                                ),
                              );
                            } finally {
                              setState(() => _loadingButton4 = false);
                            }
                          }*/
                          text: 'Cancel',
                          options: FFButtonOptions(
                            width: 130,
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
                          onPressed: () => FirebaseFirestore.instance
                              .collection('Locations')
                              .add(
                            {
                              'timestamp': Timestamp.fromDate(
                                DateTime.now(),
                              ),
                            },
                          ),
                          text: 'Create',
                          options: FFButtonOptions(
                            width: 130,
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
                          loading: _loadingButton5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
