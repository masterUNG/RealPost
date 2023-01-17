// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, sort_child_properties_last
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:realpost/utility/app_constant.dart';
import 'package:realpost/utility/app_controller.dart';
import 'package:realpost/utility/app_service.dart';
import 'package:realpost/widgets/widget_button.dart';
import 'package:realpost/widgets/widget_content_box_white.dart';
import 'package:realpost/widgets/widget_content_box_white_row.dart';
import 'package:realpost/widgets/widget_form.dart';
import 'package:realpost/widgets/widget_icon_button.dart';
import 'package:realpost/widgets/widget_text.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.bgGrey,
      appBar: AppBar(
        backgroundColor: AppConstant.bgGrey,
        foregroundColor: Colors.black,
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              print(
                  '##16jan groupProducts --> ${appController.groupProductModels.length}');
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    FocusScope.of(context).requestFocus(FocusScopeNode()),
                child: ListView(
                  children: [
                    contentImage(boxConstraints, appController),
                    contentName(boxConstraints),
                    contentDetail(boxConstraints),
                    bottonSalse(appController),
                    appController.safseProduct.value
                        ? WidgetContenBoxWhiteRow(
                            head: 'หมวดหมู่',
                            width: boxConstraints.maxWidth,
                            contentWidget: DropdownButton(
                              items: appController.groupProductModels
                                  .map(
                                    (element) => DropdownMenuItem(
                                      child: WidgetText(
                                        text: element.nameGroup,
                                        textStyle: AppConstant()
                                            .h3Style(color: Colors.black),
                                      ),
                                      value: element.nameGroup,
                                    ),
                                  )
                                  .toList(),
                              value: appController.chooseGroupProducts.last,
                              hint: WidgetText(
                                text: 'โปรดเลือกหมวดหมู่',
                                textStyle:
                                    AppConstant().h3Style(color: Colors.black),
                              ),
                              onChanged: (value) {
                                appController.chooseGroupProducts.add(value);
                              },
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            });
      }),
    );
  }

  Row bottonSalse(AppController appController) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetButton(
                        label: 'ขายสินค้า',
                        pressFunc: () {
                          appController.safseProduct.value =
                              !appController.safseProduct.value;

                          if (appController.chooseGroupProducts.isNotEmpty) {
                            appController.chooseGroupProducts.clear();
                            appController.chooseGroupProducts.add(null);
                          }
                        },
                        bgColor: Colors.white,
                        textColor: Colors.black,
                      ),
                    ],
                  );
  }

  WidgetContenBoxWhite contentDetail(BoxConstraints boxConstraints) {
    return WidgetContenBoxWhite(
      head: 'คำอธิบาย',
      width: boxConstraints.maxWidth,
      contentWidget: const WidgetForm(
        hint: 'รายละเอียด',
      ),
    );
  }

  WidgetContenBoxWhite contentName(BoxConstraints boxConstraints) {
    return WidgetContenBoxWhite(
      head: 'ชื่อ',
      width: boxConstraints.maxWidth,
      contentWidget: const WidgetForm(
        hint: 'กรอกชื่อ',
      ),
    );
  }

  WidgetContenBoxWhite contentImage(
      BoxConstraints boxConstraints, AppController appController) {
    return WidgetContenBoxWhite(
      head: 'ภาพ',
      width: boxConstraints.maxWidth,
      contentWidget: SizedBox(
        height: 80,
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            appController.xFiles.isEmpty
                ? const SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: appController.xFiles.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                width: 70,
                                height: 70,
                                child: Image.file(
                                  File(appController.xFiles[index].path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: WidgetIconButton(
                                  iconData: Icons.disabled_by_default,
                                  color: Colors.white54,
                                  padding: 1,
                                  pressFunc: () {
                                    print(
                                        '##16jan you delete index --> $index');
                                    appController.xFiles.removeAt(index);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            cardImage(string: '${appController.xFiles.length}/9'),
          ],
        ),
      ),
    );
  }

  Widget cardImage({required String string}) {
    return InkWell(
      onTap: () {
        AppService().processChooseMultiImage();
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: Card(
          color: AppConstant.bgGrey,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: AppConstant.grey,
                size: 36,
              ),
              WidgetText(
                text: string,
                textStyle: AppConstant().h3Style(color: AppConstant.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
