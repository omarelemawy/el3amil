import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class FatorahCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 5, size.height + 15);
    path.lineTo(size.width - 15, size.height);
    path.lineTo(size.width - 20, size.height + 15);
    path.lineTo(size.width - 30, size.height );
    path.lineTo(size.width - 35, size.height +15 );
    path.lineTo(size.width - 45, size.height );
    path.lineTo(size.width - 50, size.height +15 );
    path.lineTo(size.width - 60, size.height );
    path.lineTo(size.width - 65, size.height +15 );
    path.lineTo(size.width - 75, size.height  );
    path.lineTo(size.width - 80, size.height +15 );
    path.lineTo(size.width - 90, size.height  );
    path.lineTo(size.width - 95, size.height +15 );
    path.lineTo(size.width - 105, size.height  );
    path.lineTo(size.width - 110, size.height +15 );
    path.lineTo(size.width - 120, size.height  );
    path.lineTo(size.width - 125, size.height +15 );
    path.lineTo(size.width - 135, size.height  );
    path.lineTo(size.width - 140, size.height +15 );
    path.lineTo(size.width - 150, size.height  );
    path.lineTo(size.width - 155, size.height +15 );
    path.lineTo(size.width - 165, size.height  );
    path.lineTo(size.width - 170, size.height +15 );
    path.lineTo(size.width - 180, size.height  );
    path.lineTo(size.width - 185, size.height +15 );
    path.lineTo(size.width - 195, size.height  );
    path.lineTo(size.width - 200, size.height +15 );
    path.lineTo(size.width - 210, size.height  );
    path.lineTo(size.width - 215, size.height +15 );
    path.lineTo(size.width - 225, size.height  );
    path.lineTo(size.width - 230, size.height +15 );
    path.lineTo(size.width - 240, size.height  );
    path.lineTo(size.width - 245, size.height +15 );
    path.lineTo(size.width - 255, size.height  );
    path.lineTo(size.width - 260, size.height +15 );
    path.lineTo(size.width - 270, size.height  );
    path.lineTo(size.width - 275, size.height +15 );
    path.lineTo(size.width - 285, size.height  );
    path.lineTo(size.width - 290, size.height +15 );
    path.lineTo(size.width - 300, size.height  );
    path.lineTo(size.width - 305, size.height +15 );
    path.lineTo(size.width - 315, size.height  );
    path.lineTo(size.width - 320, size.height +15 );
    path.lineTo(size.width - 330, size.height  );
    path.lineTo(size.width - 335, size.height +15 );
    path.lineTo(size.width - 345, size.height  );
    path.lineTo(size.width - 350, size.height +15 );
    path.lineTo(0, size.height  );
    path.lineTo(0, size.height +15 );
    path.lineTo(0, size.height  );

    path.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = MyTheme.mainAppBlueColor;
    canvas.drawPath(path,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}