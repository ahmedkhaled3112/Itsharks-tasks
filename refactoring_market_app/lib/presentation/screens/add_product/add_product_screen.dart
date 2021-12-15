import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../presentation/widgets/adaptive/adaptive_button.dart';
import '../../../presentation/widgets/default_text_form_field.dart';
import '../../../logic/blocs/products_bloc/product_bloc.dart';
import '../../../logic/providers/user_provider.dart';
import 'package:path/path.dart' as p;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/addProduct';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<FormState>();
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _validating = false;
  bool _uploading = false;
  Map<String, dynamic> data = {};
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            autovalidateMode: _validating
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            key: _key,
            child: Column(
              children: [
                DefaultTextFormField(
                  textFieldLabel: "Title",
                  hintTextField: "please enter product title",
                  prefixIcon: const Icon(Icons.add_shopping_cart_sharp),
                  keyboardTybe: TextInputType.name,
                  obsecureText: false,
                  validator: (value) {
                    if (value!.length < 4) {
                      return "Title Can noy be less than 4 letters";
                    }
                    return "";
                  },
                  onChange: (value) {
                    setState(() {
                      data['name'] = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  textFieldLabel: "Description",
                  hintTextField: "please enter product Description",
                  prefixIcon: const Icon(Icons.edit),
                  keyboardTybe: TextInputType.name,
                  obsecureText: false,
                  validator: (value) {
                    if (value!.length < 4) {
                      return "Title Can noy be less than 4 letters";
                    }
                    return "";
                  },
                  onChange: (value) {
                    setState(() {
                      data['description'] = value;
                    });
                  },
                  maxLines: 10,
                  minLines: 5,
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  textFieldLabel: "Price",
                  hintTextField: "please enter product Price",
                  prefixIcon: const Icon(Icons.monetization_on),
                  keyboardTybe: TextInputType.number,
                  obsecureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter the price";
                    }
                    return "";
                  },
                  onChange: (value) {
                    setState(() {
                      data['price'] = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                DefaultTextFormField(
                  textFieldLabel: "Amount",
                  hintTextField: "please enter product Amount",
                  prefixIcon: const Icon(Icons.shopping_basket_outlined),
                  keyboardTybe: TextInputType.number,
                  obsecureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter the amount";
                    }
                    return "";
                  },
                  onChange: (value) {
                    setState(() {
                      data['amount'] = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Choose image Source"),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      XFile? photo = await _picker.pickImage(
                                          source: ImageSource.camera);
                                      Navigator.of(context).pop();
                                      try {
                                        setState(() {
                                          imageFile = File(photo!.path);
                                        });
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text("Camera"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      XFile? photo = await _picker.pickImage(
                                          source: ImageSource.gallery);
                                      Navigator.of(context).pop();
                                      try {
                                        setState(() {
                                          imageFile = File(photo!.path);
                                        });
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text("Gallery"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("Choose Image")),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: imageFile == null
                            ? const Center(
                                child: Text(
                                  "No Image Chosen",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _uploading
                    ? const CircularProgressIndicator()
                    : AdaptiveButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              _uploading = true;
                            });
                            data['imageUrl'] =
                                await uploadFile(imageFile!.path);
                            data['owner_id'] =
                                RepositoryProvider.of<UserProvider>(context)
                                    .getUserId();
                            BlocProvider.of<ProductsBloc>(context)
                                .add(AddProduct(data));
                            setState(() {
                              _uploading = false;
                            });
                            Navigator.of(context).pop();
                          } else {
                            setState(() {
                              _validating = true;
                            });
                          }
                        },
                        textButton: 'Add Product',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadFile(String filePath) async {
    File file = File(filePath);
    String? imageUrl;
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('products/123456${p.extension(file.path)}')
          .putFile(file);
      imageUrl = await firebase_storage.FirebaseStorage.instance
          .ref('products/123456${p.extension(file.path)}')
          .getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }
    return imageUrl;
  }
}
