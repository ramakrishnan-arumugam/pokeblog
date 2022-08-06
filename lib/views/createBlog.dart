import 'dart:io';

import 'package:pokeblog/services/addblog.dart';
import 'package:pokeblog/services/paint.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String author, title, desc, content;
  // File? sImage;
  // late File ssImage;
  ReadWrite readWrite = ReadWrite();
  PlatformFile? pickedFile;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  UploadTask? uploadTask;
  Future uploadFile() async {
    final path = 'blogImages/${randomAlphaNumeric(9)}.jpg';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    // child("blogImages")
    //     .child("${randomAlphaNumeric(9)}.jpg");

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlD = await snapshot.ref.getDownloadURL();
    Map<String, String> blogMap = {
      "imageurl": urlD,
      "AuthorName": author,
      "title": title,
      "description": desc,
      "content": content
    };
    readWrite.addData(blogMap).then((result) {

      Navigator.pop(context);
    });
    // print('Download Link: $urlD');
    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.blue,
                  ),
                  Center(
                    child: Text(
                      '${(100 * progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ));
        } else {
          return Center(
              child: SizedBox(
            height: 20,
            width: 40,
          ));
        }
      });

  // final ImagePicker _picker = ImagePicker();
  // Future getImage() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     sImage = File(image!.path);
  //
  //     // ssImage = image as File;
  //   });
  // }
  //
  bool _isloading = false;
  // uploadBlog() async {
  //   // var url;
  //   if (sImage != null) {
  //     setState(() {
  //       _isloading = true;
  //     });
  //     FirebaseStorage Storage = FirebaseStorage.instance;
  //     try {
  //       await Storage.ref('test/img.jpg').putFile(sImage!);
  //     } catch (e) {
  //       print(e);
  //     }
  //     // Reference stref = Storage.ref()
  //     // .child("blogImages")
  //     // .child("${randomAlphaNumeric(9)}.jpg");
  //     // final UploadTask task = stref.putFile(sImage!);
  //     // // task.whenComplete(() => url = ref.getDownloadURL());
  //     // var imageUrl;
  //     // await task.whenComplete(() async {
  //     //   imageUrl = await stref.getDownloadURL();
  //     // });
  //     // Map<String, String> blogMap = {
  //     //   "imageurl": imageUrl,
  //     //   "AuthorName": author,
  //     //   "title": title,
  //     //   "description": desc,
  //     // };
  //     // crudMethods.addData(blogMap).then((result) {
  //     Navigator.pop(context);
  //     // });
  //   } else {
  //     print("error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              // backgroundColor: Colors.transparent,
              elevation: 0.0,
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Poke',
                  style: TextStyle(fontSize: 22, color: Colors.green),
                ),
                Text(
                  "Blog",
                  style: TextStyle(fontSize: 22, color: Colors.lightBlue),
                )
              ]),
              actions: [
                GestureDetector(
                  onTap: () {
                    uploadFile();
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(Icons.file_upload)),
                )
              ],
            ),
            body: CustomPaint(
              painter: HeaderPainter(),
              size: const Size(double.infinity, 200),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Container(
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            selectFile();
                          },
                          child: pickedFile != null
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  // color: Colors.green,
                                  child: Image.file(
                                    File(pickedFile!.path!),
                                  ))
                              : Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black38.withAlpha(50),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Author Name",
                                // enabledBorder: UnderlineInputBorder(
                                //   borderSide: BorderSide(color: Colors.black87),
                                // ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                                // border: UnderlineInputBorder(
                                //   borderSide: BorderSide(color: theColor),
                                // ),
                              ),
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              cursorWidth: 2,
                              onChanged: (val) {
                                author = val;
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Title",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                              ),
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              cursorWidth: 2,
                              onChanged: (val) {
                                title = val;
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Description",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                              ),
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              cursorWidth: 2,
                              onChanged: (val) {
                                desc = val;
                              },
                            ),
                            TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Content",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                              ),
                              cursorColor: Colors.black,
                              cursorHeight: 25,
                              cursorWidth: 2,
                              onChanged: (val) {
                                content = val;
                              },
                            )
                          ]),
                        ),
                        buildProgress()
                      ]),
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
