import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:realpost/models/address_map_model.dart';
import 'package:realpost/models/chat_model.dart';
import 'package:realpost/models/room_model.dart';
import 'package:realpost/models/stamp_model.dart';
import 'package:realpost/models/user_model.dart';

class AppController extends GetxController {
  RxList<RoomModel> roomModels = <RoomModel>[].obs;
  RxList<String> docIdRooms = <String>[].obs;
  RxList<String> docIdRoomChooses = <String>[].obs;

  RxList<StampModel> stampModels = <StampModel>[].obs;
  RxList<String> emojiAddRoomChooses = <String>[].obs;
  RxList<ChatModel> chatModels = <ChatModel>[].obs;
  RxList<String> addressMaps = <String>[].obs;

  RxBool load = true.obs;
  RxList<UserModel> userModels = <UserModel>[].obs;
  RxList<File> fileAvatars = <File>[].obs;
  RxList<String> urlAvatarChooses = <String>[].obs;

  RxList<File> fileRealPosts = <File>[].obs;
  RxList<String> urlRealPostChooses = <String>[].obs;
  RxList<String> messageChats = <String>[].obs;

  RxList<TextEditingController> articleControllers =
      <TextEditingController>[TextEditingController()].obs;

  RxList<Position> positions = <Position>[].obs;

  Future<void> findUserModels() async {
    userModels.clear();
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      UserModel model = UserModel.fromMap(value.data()!);
      userModels.add(model);
    });
  }

  Future<void> readAllChat({required String docIdRoom}) async {
    if (chatModels.isNotEmpty) {
      chatModels.clear();
      addressMaps.clear();
    }

    FirebaseFirestore.instance
        .collection('room')
        .doc(docIdRoom)
        .collection('chat')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((event) async {
      load.value = false;
      if (event.docs.isNotEmpty) {
        if (chatModels.isNotEmpty) {
          chatModels.clear();
          addressMaps.clear();
        }

        for (var element in event.docs) {
          ChatModel model = ChatModel.fromMap(element.data());
          print('chatModel ==> ${model.toMap()}');
          chatModels.add(model);

          if (model.geoPoint!.latitude != 0) {
            String apiPath =
                'https://api.longdo.com/map/services/address?lon=${model.geoPoint!.longitude}&lat=${model.geoPoint!.latitude}&noelevation=1&key=cda17b2e1b8010bdfc353a0f83d59348';
            await Dio().get(apiPath).then((value) {
              print('##13dec value longDo ---> $value');
              AddressMapModel addressMapModel =
                  AddressMapModel.fromMap(value.data);
              String string =
                  '${addressMapModel.subdistrict} ${addressMapModel.district} ${addressMapModel.province} ${addressMapModel.postcode}';
              print('##13dec address ---> $string');
              addressMaps.add(string);
            });
          } else {
            addressMaps.add('');
          }
        }
      }
    });
  }

  Future<void> readAllStamp() async {
    if (stampModels.isNotEmpty) {
      stampModels.clear();
    }

    await FirebaseFirestore.instance.collection('stamp').get().then((value) {
      for (var element in value.docs) {
        StampModel model = StampModel.fromMap(element.data());
        stampModels.add(model);
      }
    });
  }

  Future<void> readAllRoom() async {
    if (roomModels.isNotEmpty) {
      roomModels.clear();
      docIdRooms.clear();
    }
    await FirebaseFirestore.instance
        .collection('room')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        RoomModel model = RoomModel.fromMap(element.data());
        roomModels.add(model);
        docIdRooms.add(element.id);
      }
    });
  }
}
