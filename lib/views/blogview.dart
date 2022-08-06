import 'package:pokeblog/services/paint.dart';
import 'package:flutter/material.dart';

class BlogView extends StatelessWidget {
  final imgUrl, title, desc, author, content;
  BlogView(
      {@required this.author,
      @required this.desc,
      @required this.imgUrl,
      @required this.title,
      @required this.content});
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              title: Text(
                title,
                style: TextStyle(fontSize: 22, color: Colors.lightBlue,
                    fontFamily: 'Tapestry',fontWeight: FontWeight.bold),
              ),
            ),
            // backgroundColor: Colors.black.withAlpha(60),
            body: CustomPaint(
              painter: HeaderPainter(),
              size: const Size(double.infinity, 200),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Image.network(
                          imgUrl,
                          width: MediaQuery.of(context).size.width,
                          // fit: BoxFit.fitHeight,
                          height: 400,
                              fit: BoxFit.cover,
                        )),
                        SizedBox(height: 25,),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            desc,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700,
                                color: Colors.black87,fontFamily: 'Tapestry'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          // color: Colors.green,
                          child: Text(
                            content,
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Container(
// child:  ListView.builder(
//   padding: EdgeInsets.only(top: 24),
//    itemCount: 10,
//   itemBuilder: (context, index) {
//     return Container(
//       margin:  EdgeInsets.only(bottom:16,right: 8, left: 8),
//       // EdgeInsets.only(bottom: 24, right: 16, left: 16),
//       height: 180,
//       decoration: BoxDecoration(color: Colors.black45.withOpacity(0.3),
//         borderRadius: BorderRadius.all(Radius.circular(8)),) ,
//       child: Image.network(
//         imgUrl,
//         width: MediaQuery.of(context).size.width,
//         fit: BoxFit.cover,
//         height: 180,
//         // width: MediaQuery.of(context).size.width,
//         // fit: BoxFit.cover,
//       ),
//     );
//
// },
// ),
//   );
//   }
// }
