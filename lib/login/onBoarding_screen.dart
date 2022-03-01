import 'package:flutter/material.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controllerPage = PageController();

  bool isLast = false;

  final List<BoardingModel>
  boardingItems = [
    BoardingModel(url: "assets/onboard1.jpg",
        title: "مرحلة الاستلام والتقييم",
        body: "",
        body1: "أستلم طلبك و لاتنسى تقييم المسافر على أنجازه",
        body2: "",
    ),
    BoardingModel(url: "assets/onboard2.jpg",
        title: "مرحلة  التوثيق والتأكيد",
        body: "",
        body1: "أطلب فاتورة  وأكد بأدخال الكود وسوف يصدر لك رقم طلب",
        body2: "عدم وجود رقم للطلب دليل عدم أكتمال طلبك  ولن تستطيع متالبعته",),
    BoardingModel(url: "assets/onboard3.jpg",
        title: "مرحلة التفاوض",
        body: "",
        body1: "  تواصل عبر الشات وأتفقو على سعر يرضي الطرفين",
        body2: "  التفاوض عبر الشات غير ملزم على أي طرف حتى يتم  تأكيد الفاتورة",),
    BoardingModel(url: "assets/onboard4.jpg",
        title: "توصيل مع مسافر",
        body: "نحن جاهزون لخدمتك" ,
        body1: "هنا تجمع المسافرين  لتقديم خدماتهم  بأي مدينة",
         body2: "توصيل بين المدن  -شراء - شحن - خدمات منوعة",),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(onPressed: (){
              submit();
            }, child:
             Text("تخطي",style: TextStyle(fontSize: 16,fontFamily: "beIN",color: HexColor("#827C7C"),
                fontWeight: FontWeight.bold),)),
            SizedBox(width: 20,),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(controller: controllerPage,
                  itemBuilder: (BuildContext context, int index) {
                    return widgetBoardingItem(boardingItems[index]);
                  },
                  itemCount: boardingItems.length,
                  onPageChanged: (index) {
                    if (index == boardingItems.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),),
              ),
              const SizedBox(height: 40,),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controllerPage, // PageController
                    count: boardingItems.length,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        strokeWidth: 10,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4
                    ),
                    // your preferred effect
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        controllerPage.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      }
                    }
                    ,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded, color: Colors.white,),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
  Widget widgetBoardingItem(BoardingModel model)
  =>Column(
    children: [
      Center(
        child: Text(model.body, style: TextStyle(fontSize: 18,fontFamily: "Graffiti",color: Colors.black,
            fontWeight: FontWeight.bold),),
      ),
      Expanded(child: Image(image: AssetImage(model.url))),
      const SizedBox(height: 15,),
      Center(child: Text(model.title, style: TextStyle(fontSize: 14,fontFamily: "beIN",color: HexColor("#5787A6"),
          fontWeight: FontWeight.bold),)),
      const SizedBox(height: 2,),
      Center(child: Text(model.body1, style: TextStyle(fontSize: 11,fontFamily: "beIN",color: HexColor("#827C7C")),)),
      const SizedBox(height: 2,),
      Center(child: Text(model.body2, style: TextStyle(fontSize: 11,fontFamily: "beIN",color: HexColor("#5787A6")),)),
      const SizedBox(height: 10,),
    ],
  );

  void submit()
  {
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if(value)
      {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
      }
    });
  }
}
class BoardingModel{
  final String url;
  final String title;
  final String body;
  final String body1;
  final String body2;

  BoardingModel({
    @required this.url,
    @required this.title,
    @required this.body,
    @required this.body1,
    @required this.body2,

  });
}
