import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shlink_app/common.dart';
import 'package:shlink_app/types/ServiceException.dart';
import 'package:shlink_app/types/services/ShortishCloud.dart';
import 'package:shlink_app/views/settings/ShortishCloud/ShortishCloudOptInView.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ShortishCloudImportView extends StatefulWidget {
  ShortishCloudImportView({Key? key}) : super(key: key);

  @override
  _ShortishCloudImportViewState createState() =>
      _ShortishCloudImportViewState();
}

class _ShortishCloudImportViewState extends State<ShortishCloudImportView> {
  //final box = Hive.box("preferences");
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController _apiKeyControll = new TextEditingController();
  final _apiKeyfocusNode = FocusNode();
  final uuidRegex = RegExp(
      "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}");
  bool showQRReader = !kIsWeb;
  bool loading = false;
  String? apiKey;
  //final GlobalKey qrKey = GlobalKey();
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        controller?.pauseCamera();
      } else if (Platform.isIOS) {
        controller?.resumeCamera();
      }
    }
  }

  @override
  void dispose() {
    _apiKeyfocusNode.dispose();
    _apiKeyControll.dispose();
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _apiKeyControll.text = result?.code ?? "";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _apiKeyfocusNode.addListener(() {
        setState(() {
          showQRReader = !_apiKeyfocusNode.hasPrimaryFocus;
        });
      });
    }
    _apiKeyControll.addListener(() {
        if (uuidRegex.hasMatch(_apiKeyControll.text)) {
          setState(() {
            apiKey = _apiKeyControll.text;
          });
        } else {
          setState(() {
            apiKey = null;
          });
        }
      });

    //box.get("shortish_cloud_state", defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Import Shortish Cloud"),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: BackButton(
            onPressed: () {
              if (Get.previousRoute == "") {
                Get.offAllNamed("/settings");
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            width: Get.width,
            child: Column(
              children: [
                //Text("Import an existing Shortish Cloud account", style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
                SizedBox(height: 30),
                Expanded(
                  flex: 1,
                  child: Text(
                    "If you already have a device with Shortish Cloud enabled, go to Settings > Shortish Cloud and then select \"Show API Key\"",
                  ),
                ),
                (showQRReader)
                    ? Expanded(
                        flex: 7,
                        child: Container(
                            constraints:
                                BoxConstraints(maxWidth: 600, maxHeight: 600),
                            padding: EdgeInsets.all(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: QRView(
                                key: qrKey,
                                onQRViewCreated: _onQRViewCreated,
                              ),
                            )))
                    : Container(),
                Expanded(
                  flex: 5,
                  child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 600, maxHeight: 600),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (uuidRegex.hasMatch(val ?? "")) {
                                return null;
                              }
                              return "Must be a valid API key";
                            },
                            focusNode: _apiKeyfocusNode,
                            controller: _apiKeyControll,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: (kIsWeb)?"Paste API key here":'or paste API key here'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoButton.filled(
                              child: Text((loading) ? "Loading" : "Import"),
                              onPressed: (apiKey != null || loading == true)
                                  ? () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      try {
                                        await ShortishCloud.importUser(apiKey!);
                                        setState(() {
                                          loading = false;
                                        });
                                        Get.offAllNamed("/");
                                      } catch (e) {
                                        setState(() {
                                          loading = false;
                                        });

                                        if (e.runtimeType == ServiceException) {
                                          var err = e as ServiceException;
                                          if (err.httpStatus == 401 ||
                                              err.httpStatus == 403) {
                                            showSnackBar(
                                                text: "Invalid API Key");
                                          } else {
                                            showSnackBar(text: e.title);
                                          }
                                        } else {
                                          print(e);
                                          showSnackBar(
                                              text: "Unknown Error: " +
                                                  e.toString());
                                        }
                                      }
                                    }
                                  : null),
                        ],
                      )),
                )
              ],
            )));
  }
}
