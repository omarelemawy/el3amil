import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mosafer1/Fatorah/bloc/cubit.dart';
import 'package:mosafer1/Fatorah/bloc/state.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/Widgets/FatoragShape.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'dart:ui' as ui;

class FatorahPage extends StatelessWidget {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    final FatorahCubit fatorahCubit = BlocProvider.of<FatorahCubit>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: TextButton(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              fatorahCubit.emit(InitialFatorahState());
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              child: SVGIcons.barIcon,
              onPressed: () {},
            ),
          ],
          title: Text(
            "الفاتورة",
            style: TextStyle(fontFamily: "beIN"),
          ),
        ),
        body: Directionality(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            child: BlocProvider<FatorahCubit>(
              create: (context) => FatorahCubit()..getFatorah(1),
              child: BlocConsumer<FatorahCubit,FatorahState>(
                listener: (context,state){},
                builder: (context,state) {
                  if(state is LoadedFatorahState) {
                    print("Fatorah Data : ${state.fatorahModel}");
                    return Column(
                      children: [
                        IntrinsicHeight(
                          child: Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: size.width * 0.9,
                                    minWidth: size.width * 0.9,
                                    minHeight: size.height * 0.8),
                                child: CustomPaint(
                                  child: Column(
                                    children: [
                                      Padding(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SVGIcons.hoursIcon,
                                            Padding(
                                                child: Text(
                                                  "الفاتورة",
                                                  style: MyTheme.defaultAppTextTheme()
                                                      .textTheme
                                                      .headline1,
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 10))
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(top: 20),
                                      ),
                                      Divider(
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                      Text(
                                          "  تاريخ الطلب  " +
                                              DateFormat.yMMMMEEEEd()
                                                  .format(DateTime.parse(state.fatorahModel.createdAt)),
                                          style: MyTheme.defaultAppTextTheme()
                                              .textTheme
                                              .headline2),
                                      Divider(
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("تاريخ نهاية الخدمة",
                                              style: MyTheme.defaultAppTextTheme()
                                                  .textTheme
                                                  .headline2),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(DateFormat.yMMMMEEEEd()
                                                .format(DateTime.now())),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                          ),
                                        ],
                                      ),
                                      Utils.vSpace(15),
                                      Column(
                                        children: List<Widget>.generate(
                                          state.fatorahModel.fatorahItems.length,
                                              (index) => Padding(
                                            child: Row(
                                              children: [
                                                Text(state.fatorahModel.fatorahItems[index].subject,
                                                    style: MyTheme.defaultAppTextTheme()
                                                        .textTheme
                                                        .bodyText1),
                                                Spacer(),
                                                Text("${state.fatorahModel.fatorahItems[index].value} ر.س",
                                                    style: MyTheme.defaultAppTextTheme()
                                                        .textTheme
                                                        .bodyText1),
                                              ],
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                      Padding(
                                        child: Row(
                                          children: [
                                            Text("خصم كوبون ",
                                                style: MyTheme.defaultAppTextTheme()
                                                    .textTheme
                                                    .headline2),
                                            Utils.hSpace(20),
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration.collapsed(
                                                  hintText: "ضع رمز الخصم",
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text("تاكيد",style: TextStyle(color: MyTheme.mainAppBlueColor),),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(
                                                    Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        padding:
                                        const EdgeInsets.only(left: 15, right: 15),
                                      ),
                                      Divider(
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                      Utils.vSpace(15),
                                      Padding(
                                        child: Row(
                                          children: [
                                            Text("المبلغ الاجمالي ",
                                                style:
                                                MyTheme.defaultAppTextTheme()
                                                    .textTheme
                                                    .headline2),
                                            Spacer(),
                                            Text(
                                                state.totalFatorahPrice.toString() +
                                                    " ر.س ",
                                                style:
                                                MyTheme.defaultAppTextTheme()
                                                    .textTheme
                                                    .headline2),
                                          ],
                                        ),
                                        padding:
                                        const EdgeInsets.only(left: 15, right: 15),
                                      )
                                    ],
                                  ),
                                  painter: FatorahCustomPainter(),
                                  size: Size(size.width * 0.9, size.height * 0.8),
                                ),
                              ),
                              Align(
                                child: ElevatedButton(
                                  onPressed: () {
                                    fatorahCubit.emit(InitialFatorahState());
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(CircleBorder()),
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.brown)),
                                ),
                                alignment: AlignmentDirectional.topStart,
                              )
                            ],
                          ),
                        ),
                        Utils.vSpace(20),
                        Directionality(
                            textDirection: ui.TextDirection.ltr,
                            child: StatefulBuilder(
                              builder: (context, state) => CheckboxListTile(
                                onChanged: (val) {
                                  state(() => _checked = !_checked);
                                },
                                title: RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                      text:  "أتعهد  عند  طلب الإلغاء يكون  قبل  12 ساعة أو بالاتفاق مع المسافر مع عدم  تعطيل مصالحه ",
                                      style: TextStyle(color: Colors.black54),
                                      children: [
                                        TextSpan(
                                          text: ' راجع سياسة التطبيق ',
                                          style: TextStyle(color: Colors.brown),
                                        )
                                      ]
                                  ),
                                ),
                                value: _checked,
                              ),
                            )),
                        Utils.vSpace(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Utils.hSpace(20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("دفع الكتروني "),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      MyTheme.mainAppBlueColor),
                                ),
                              ),
                            ),
                            Utils.hSpace(10),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text("رفض"),
                                style: ButtonStyle(),
                              ),
                            ),
                            Utils.hSpace(20),
                          ],
                        ),
                        Utils.vSpace(10),
                      ],
                    );
                  }
                  return Center(child: Text("جاري قراة البيانات"),);
                },
              ),
            ),
          ),
          textDirection: ui.TextDirection.rtl,
        ));
  }
}
