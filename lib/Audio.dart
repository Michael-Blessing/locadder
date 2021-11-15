import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioWidget extends StatefulWidget {
  AudioWidget({Key key}) : super(key: key);

  @override
  _AudioWidgetState createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'data:image/png;base64,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',
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 160, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 10),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.black,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            fillColor: Colors.transparent,
                            icon: FaIcon(
                              FontAwesomeIcons.play,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.black,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: FaIcon(
                              FontAwesomeIcons.pause,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.black,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: FaIcon(
                              FontAwesomeIcons.microphone,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                          child: FlutterFlowIconButton(
                            borderColor: Colors.black,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: FaIcon(
                              FontAwesomeIcons.stop,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
