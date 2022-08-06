import 'package:pokeblog/services/addblog.dart';
import 'package:pokeblog/services/paint.dart';
import 'package:pokeblog/services/test.dart';
import 'package:pokeblog/views/blogview.dart';
import 'package:pokeblog/views/createBlog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ReadWrite readWrite = ReadWrite();
  QuerySnapshot? blogSnapshot;

  @override
  void initState() {
    readWrite.getData().then((result) {
      blogSnapshot = result;
      setState(() {});
    });
    super.initState();
  }

  Widget blogsList() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () async {
           initState();
        },
        child: ListView.builder(
          padding: EdgeInsets.only(top: 24),
          itemCount: blogSnapshot!.docs.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return BlogTile(
              author: blogSnapshot!.docs[index].get('AuthorName'),
              title: blogSnapshot!.docs[index].get('title'),
              desc: blogSnapshot!.docs[index].get('description'),
              imgUrl: blogSnapshot!.docs[index].get('imageurl'),
              content: blogSnapshot!.docs[index].get('content'),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Poke',
            style: TextStyle(fontSize: 22),
          ),
          Text(
            "Blog",
            style: TextStyle(fontSize: 22, color: Colors.lightBlue),
          )
        ]),
      ),
      body: CustomPaint(
        painter: HeaderPainter(),
        size: const Size(double.infinity, 200),
        child: Container(
            child: blogSnapshot != null
                ? blogsList()
                : Container(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateBlog()));
           },
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final imgUrl, title, desc, author, content;
  BlogTile(
      {@required this.author,
      @required this.desc,
      @required this.imgUrl,
      @required this.title,
      @required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, right: 8, left: 8),
      // EdgeInsets.only(bottom: 24, right: 16, left: 16),

      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // RaisedButton(
          //   color: Colors.transparent,
          //
          //   child: SizedBox(
          //     height: 180,
          //     width: MediaQuery.of(context).size.width,
          //   ),
          //   // height:180,
          //   // minWidth:double.infinity,
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => BlogView(
          //                   author: author,
          //                   desc: desc,
          //                   imgUrl: imgUrl,
          //                   title: title,
          //                   content: content,
          //                 )));
          //   },
          // ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                // height: 180,
                height: 350,

              ),
            ),
          ),
          Container(
            // height: 180,
            height: 350,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          Container(
            // height: 180,
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  author,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          RaisedButton(
            color: Colors.transparent,

            child: SizedBox(
              // height: 180,
              height: 350,
              width: MediaQuery.of(context).size.width,
            ),
            // height:180,
            // minWidth:double.infinity,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlogView(
                            author: author,
                            desc: desc,
                            imgUrl: imgUrl,
                            title: title,
                            content: content,
                          )));
            },
          ),
        ],
      ),
    );
  }
}

//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text(
//             'Poke',
//             style: TextStyle(fontSize: 22),
//           ),
//           Text(
//             "Blog",
//             style: TextStyle(fontSize: 22, color: Colors.lightBlue),
//           )
//         ]),
//       ),
//       body: Container(),
//       floatingActionButton: Container(
//         padding: EdgeInsets.symmetric(vertical: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => CreateBlog()));
//
//               },child: Icon(Icons.add),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//

// PlatformFile? pickedFile;
// Future selectFile() async {
//   final result = await FilePicker.platform.pickFiles();
//   if (result == null) return;
//   setState(() {
//     pickedFile = result.files.first;
//   });
// }
//
// UploadTask? uploadTask;
// Future uploadFile() async {
//   final path = 'files/my-ima.jpg';
//   final file = File(pickedFile!.path!);
//
//   final ref = FirebaseStorage.instance.ref().child(path);
//
//   setState(() {
//     uploadTask = ref.putFile(file);
//   });
//
//   final snapshot = await uploadTask!.whenComplete(() {});
//   final urlD = await snapshot.ref.getDownloadURL();
//   print('Download Link: $urlD');
//   setState(() {
//     uploadTask = null;
//   });
// }
//
// Widget buildProgress() => StreamBuilder<TaskSnapshot>(
//     stream: uploadTask?.snapshotEvents,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         final data = snapshot.data!;
//         double progress = data.bytesTransferred / data.totalBytes;
//         return SizedBox(
//             height: 50,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 LinearProgressIndicator(
//                   value: progress,
//                   backgroundColor: Colors.grey,
//                   color: Colors.blue,
//                 ),
//                 Center(
//                   child: Text(
//                     '${(100 * progress).roundToDouble()}%',
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 )
//               ],
//             ));
//       } else {
//         return Center(
//           child: Container(
//             height: 20,
//             width: 20,
//             color: Colors.red,
//           ),
//         );
//       }
//     });
