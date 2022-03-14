import 'package:flutter/material.dart';

class TermsAndPolicies extends StatefulWidget {
  const TermsAndPolicies({Key key}) : super(key: key);

  @override
  _TermsAndPoliciesState createState() => _TermsAndPoliciesState();
}

class _TermsAndPoliciesState extends State<TermsAndPolicies> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("سياسة التطبيق",style: TextStyle(fontSize: 18),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("هدف التطبيق :",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline),),
                Text("نواجه كثير من المواقف التي نجبر علي ارسال شنات سريعة لأنهاء معاملاتنا اونتخوف من عدم ايصال شحنات غالية وكذلك المسافر يتخوف ان ينجز العمل ولا يتحصل علي حقوقه لذلك هذا التطبيق هو حل لمشاكل قد نواجهها تحت أنظمة معترف بها فالتطبيق مجاني لا يتحصل علي رسوم او عمولات من المسافر او العميل والاستلام يكون يد بيد او حسب اتفاق الطرفين.",style: TextStyle(fontSize: 14,height: 1.5),),
                Text("الشروط :",style: TextStyle(fontSize: 18,decoration: TextDecoration.underline),),
                Text("التطبيق عبارة عن وسيط ومشرف وله حق المتابعة والتنظيم والتقيم والايقاف عند التلاعب وعدم الجدية.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("المسافر الغير فعلي بالسفر عليه وضع اعلان اما حسب الطلب او كأعلان مسافر دائم.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("اذا طلب العميل التأمين يحق له التعويض في حالة الفقد حسب السعر الذي وضعه اثناء الطلب رسوم التأمين يدفعها صاحب الطلب وهي من المسافر يستلمها عند انجاز المهمة .",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("في حالة واحدة يتحصل التطبيق علي رسوم اذا طلب صاحب الطلب الدفع عبر التطبيق.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("أدارة التطبيق لاتتحمل المسئولية عن الطلبات الغير مؤمنة او الاتفاق خارق التطبيق او نقص البيانات او الأخلال بصفة العمل.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("علي صاحب الطلب ان يكون موثوق برقم هوية وهاتف وان يرفع صور للطلب او سوف لن ينظر الي شكواه.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("علي المسافر والعميل عدم الترك من المكان قبل ادخال اكواد الاستلام والتسليم ومطابقة رقم الهوية علي العميل والمسافر التقيد بالصور والمعاينة وأدخال كود التسليم والاستلام قبل مغادرة المكان.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("علي العميل والمسافر الغاء الرحلة قبل السفر ب24 ساعة او الرفع بالالغاء للدعم الفني.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("التقيد بأنظمة كل بلد بعدم حمل ممنوعات أو مستلزمات ومواد غير مصرحة بها.",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("الاخلال بالشروط وعدم التقيد بها يتحملها المخالف وتكون ادارة التطبيق خارج المسؤلية .",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
                Text("الشروط قابلة للتغير والتحديث ولايحق له الادعاء بالجهالة .",style: TextStyle(fontSize: 14,height: 1.5),),
                SizedBox(height: 8,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
