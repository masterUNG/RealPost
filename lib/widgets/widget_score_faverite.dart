// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realpost/models/chat_model.dart';
import 'package:realpost/states/comment_chat.dart';
import 'package:realpost/utility/app_constant.dart';

import 'package:realpost/utility/app_controller.dart';
import 'package:realpost/utility/app_service.dart';
import 'package:realpost/widgets/widget_amount_comment.dart';
import 'package:realpost/widgets/widget_display_up.dart';
import 'package:realpost/widgets/widget_image.dart';
import 'package:realpost/widgets/widget_text.dart';

class WidgetScoreFaverite extends StatelessWidget {
  const WidgetScoreFaverite({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          return Row(
            children: [
              WidgetText(
                text: 'จำนวนคนในห้อง',
                textStyle: AppConstant()
                    .h3Style(size: 15, color: AppConstant.realFront),
              ),
              const SizedBox(
                width: 5,
              ),
              WidgetText(
                text: appController.chatModels[index].traffic.toString(),
                textStyle: AppConstant()
                    .h3Style(size: 15, color: AppConstant.realFront),
              ),
              const SizedBox(
                width: 20,
              ),
              WidgetAmountComment(
                amountComment: appController.amountComments[index],
              ),
              const SizedBox(
                width: 20,
              ),
              WidgetImage(
                path: 'images/up.jpg',
                size: 36,
                tapFunc: () {
                  String docIdChat = appController.docIdChats[index];
                  print('docIdChat --> $docIdChat');

                  Map<String, dynamic> map =
                      appController.chatModels[index].toMap();

                  map['timestamp'] = Timestamp.fromDate(DateTime.now());
                  ChatModel chatModel = ChatModel.fromMap(map);

                  print('chatModel New ---> ${chatModel.toMap()}');

                  AppService()
                      .processUpdateChat(
                          docIdChat: docIdChat, chatModel: chatModel)
                      .then((value) {
                    Get.back();
                  });
                },
              ),
              const SizedBox(
                width: 5,
              ),
              WidgetDisplayUp(indexChat: index,),
            ],
          );
        });
  }
}
