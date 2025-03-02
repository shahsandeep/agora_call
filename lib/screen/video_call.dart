import 'dart:async';

import 'package:agora_call/models/agora_model.dart';
import 'package:agora_call/service/firebase_service.dart';
import 'package:agora_call/utils/const/const.dart';
import 'package:agora_call/utils/helper/helper.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum CallStatus {
  calling('ringing'),
  connected('connected'),
  disconnected('disconnected'),
  noAnswer('no_answer');

  final String value;
  const CallStatus(this.value);
}

class AgoraVideoCall extends StatefulWidget {
  final bool isCaller;
  final AgoraCallParamsModel params;
  const AgoraVideoCall(
      {required this.isCaller, required this.params, super.key});

  @override
  State<AgoraVideoCall> createState() => _AgoraVideoCallState();
}

class _AgoraVideoCallState extends State<AgoraVideoCall> {
  AgoraClient? client;
  Timer? timer;
  final FirebaseRepo callProvider = FirebaseRepo();

  bool isCaller = true;
  String currentUserId = "1";
  String callerName = "Caller";
  String receiverName = '';
  String? channelName = '';
  String callType = 'video';
  bool _isCallDisconnected = false;
  String peerName = '';

  @override
  void initState() {
    super.initState();

    _initAgora();
  }

  void _initAgora() async {
    receiverName = widget.params.receiverName ?? "";
    peerName = receiverName;

    if (widget.params.callerId != currentUserId &&
        widget.params.callerId != null) {
      isCaller = false;
      callerName = widget.params.callerName ?? "";
      receiverName = "Caller";
      peerName = callerName;
    }

    String callStatus = 'connected';

    channelName = widget.params.channelName;
    if (channelName == null) {
      channelName = "agoratest";
      callStatus = 'ringing';
    }

    FirebaseRepo().createOrUpdateCallDocument(
        callerId: currentUserId,
        callerName: callerName,
        receiverName: receiverName,
        channelId: channelName ?? "",
        receiverId: widget.params.receiverId ?? "",
        status: callStatus,
        callType: callType);

    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConstants.appId,
        tempToken: widget.params.tempToken ?? AgoraConstants.token,
        channelName: channelName ?? '',
        username: 'Caller',
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );
    await client?.initialize();
    if (client?.isInitialized ?? false) {
      client?.engine.setEnableSpeakerphone(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: callProvider.videoCallStream(
                isCaller: isCaller, channelName: channelName),
            builder: (ctx, snapshot) {
              String status = 'ringing';
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isNotEmpty) {
                  status = snapshot.data!.docs.first.data()['status'];
                  if (status == 'disconnected') {
                    // Helpers.showToast("Call Disconnected");

                    if (mounted && !_isCallDisconnected) {
                      _isCallDisconnected = true;
                      Navigator.pop(context);
                    }
                  }
                }
              }
              return SafeArea(
                child: client != null
                    ? Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                AgoraVideoViewer(
                                  client: client!,
                                  layoutType: Layout.oneToOne,
                                  showNumberOfUsers: true,
                                ),
                                AgoraVideoButtons(
                                  client: client!,
                                  onDisconnect: () {
                                    _isCallDisconnected = true;
                                    FirebaseRepo().createOrUpdateCallDocument(
                                        callerId: currentUserId,
                                        receiverName: receiverName,
                                        callerName: callerName,
                                        channelId: channelName ?? '',
                                        receiverId:
                                            widget.params.receiverId ?? "",
                                        status: 'disconnected',
                                        callType: callType);
                                    Navigator.pop(context);
                                    Helpers.showToast("Call Disconnected");
                                  },
                                ),
                                if (status == 'ringing')
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Card(
                                        color: Colors.black.withOpacity(0.5),
                                        child: const Text(
                                          '   Connecting...   ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        )),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    client?.release();
    timer?.cancel();
  }
}
