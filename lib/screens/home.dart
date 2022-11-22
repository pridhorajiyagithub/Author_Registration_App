import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
<<<<<<< HEAD
=======

>>>>>>> cb4f9bdbcd3f5758ff316c6d4342bcd13adba1e8
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import '../global.dart';
import '../hepler class/author_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> insertFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

//---------------------------
  Uint8List? image;
  Uint8List? decodedImage;
  String encodedImage = "";
<<<<<<< HEAD
  //String books = "";
=======
  String books = "";
>>>>>>> cb4f9bdbcd3f5758ff316c6d4342bcd13adba1e8
  //------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Author Registration App"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CloudFirestoreHelper.cloudFirestoreHelper.selectRecord(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot? data = snapshot.data;
            List<QueryDocumentSnapshot> documents = data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                if (documents[index]["image"] != null) {
                  decodedImage = base64Decode(documents[index]["image"]);
                } else {
                  decodedImage == null;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Card(
                    elevation: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(0.5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  alignment: Alignment.center,
                                  color: Colors.blueGrey.withOpacity(0.7),
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${documents[index]['title']}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    /*await CloudFirestoreHelper.cloudFirestoreHelper
                                      .updateRecord(id: "${documents[index]}");*/
                                    validateAndEditData(
<<<<<<< HEAD
                                        id: documents[index].id,
                                        data: documents[index]);
=======
                                        id: documents[index].id);
>>>>>>> cb4f9bdbcd3f5758ff316c6d4342bcd13adba1e8
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await CloudFirestoreHelper
                                        .cloudFirestoreHelper
                                        .deleteRecord(id: documents[index].id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 370,
                            color: Colors.blueGrey.withOpacity(0.1555),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 70,
                                ),
                                const Expanded(
                                  child: Text(
                                    "Book Name : ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Expanded(
                                  child: Text("${documents[index]['details']}",
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.left),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 400,
                            width: double.infinity,
                            child: decodedImage == null
                                ? const Text(
                                    "ADD IMAGE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                : Container(
                                    height: 400,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.blueGrey.withOpacity(0.1555),
                                    ),
                                    child: Image.memory(
                                      decodedImage!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                            /* Image.network(
                              documents[index]['image']!,
                              fit: BoxFit.cover,
                            )*/
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          setState(
            () async {
              await validateAndInsertData();
            },
          );
        },
      ),
    );
  }

  validateAndInsertData() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Insert Details"),
        actions: [
          ElevatedButton(
              onPressed: () async {
                if (insertFormKey.currentState!.validate()) {
                  insertFormKey.currentState!.save();
                  Map<String, dynamic> data = {
                    'title': Global.title,
                    'details': Global.name,
                    'image': encodedImage,
                  };
                  CloudFirestoreHelper.cloudFirestoreHelper
                      .insertRecord(data: data);
                  titleController.clear();
                  detailsController.clear();
                  setState(() {
                    Global.title = "";
                    Global.name = "";
                    Global.image == "";
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add")),
          OutlinedButton(
              onPressed: () async {
                titleController.clear();
                detailsController.clear();
                setState(() {
                  Global.title = "";
                  Global.name = "";
                  Global.image == "";
                });
                Navigator.of(context).pop();
              },
              child: const Text("Remove")),
        ],
        content: Form(
          key: insertFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  /* XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    //  Global.image = File(pickedFile!.path);
                  });*/

                  //---------------------------------------------
                  /*     ImagePicker _picker = ImagePicker();
                  XFile? pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  print("${pickedFile?.path}");
                  Uint8List uint8list = await pickedFile!.readAsBytes();
                  String path = uint8list.toString();

                  if (pickedFile == null) return;
                  Reference refrenceroot = FirebaseStorage.instance.ref();
                  Reference refDirImg = refrenceroot.child('images');
                  Reference refrenceImageToUpload = refDirImg.child('name');*/
                  //--------------------------------------------------

                  /*  try {
                    await refrenceImageToUpload.putFile(File(pickedFile!.path));
                    imageUrl = await refrenceImageToUpload.getDownloadURL();
                  } catch (error) {}
*/
                  /*   try {
                    await refrenceImageToUpload.putString(path);
                    imageUrl = await refrenceImageToUpload.getDownloadURL();
                  } catch (error) {}*/

                  //---------------------------------------

                  final ImagePicker _picker = ImagePicker();

                  XFile? img =
                      await _picker.pickImage(source: ImageSource.gallery);

                  if (img != null) {
                    File compressedImage =
                        await FlutterNativeImage.compressImage(img.path);
                    image = await compressedImage.readAsBytes();
                    encodedImage = base64Encode(image!);
                  }
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  width: 250,
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: Colors.black45.withOpacity(0.4),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "+ Add Image of Book",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.60)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                    hintText: "Enter title here..."),
                controller: titleController,
                validator: (val) => (val!.isEmpty) ? "Enter name first" : null,
                onSaved: (val) {
                  Global.title = val;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                maxLines: 3,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                    hintText: "Enter name here..."),
                controller: detailsController,
                validator: (val) => (val!.isEmpty) ? "Enter name first" : null,
                onSaved: (val) {
                  Global.name = val;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateAndEditData(
      {required String id, required QueryDocumentSnapshot data}) async {
    String book = data['details'];
    String name = data['title'];
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update details"),
        content: Form(
          key: updateFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (val) {
                  (val!.isEmpty) ? "Enter title First..." : null;
                  return null;
                },
                onSaved: (val) {
                  Global.title = val;
                },
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter title Here....",
                    labelText: book),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (val) {
                  (val!.isEmpty) ? "Enter Details First..." : null;
                  return null;
                },
                onSaved: (val) {
                  Global.name = val;
                },
                maxLines: 3,
                controller: detailsController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter details Here....",
                    labelText: name),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () {
              if (updateFormKey.currentState!.validate()) {
                updateFormKey.currentState!.save();

                Map<String, dynamic> data = {
                  'title': Global.title,
                  'details': Global.name,
                  'image': encodedImage,
                };
                CloudFirestoreHelper.cloudFirestoreHelper
                    .updateRecord(id: id, updateData: data);
              }
              titleController.clear();
              detailsController.clear();

              Global.title = "";
              Global.name = "";
              Navigator.of(context).pop();
            },
          ),
          OutlinedButton(
            child: const Text("Cancel"),
            onPressed: () {
              titleController.clear();
              detailsController.clear();

              Global.title = "";
              Global.name = "";
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

//  Future uploadImage(File Global.image) {}
}
