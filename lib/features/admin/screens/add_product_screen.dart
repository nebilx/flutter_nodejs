import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nodejs/common/widgets/custom_button.dart';
import 'package:flutter_nodejs/common/widgets/custom_textfield.dart';
import 'package:flutter_nodejs/constants/global_variable.dart';
import 'package:flutter_nodejs/constants/utils.dart';
import 'package:flutter_nodejs/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();

  String Category = 'Mobiles';

  List<File> images = [];

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  void addProdcut() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.addProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: Category,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariable.appBarGradient),
              ),
              title: Center(
                child: const Text('Add Product',
                    style: TextStyle(
                      color: Colors.black,
                    )),
              )),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 200,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Select Product Image',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: productNameController,
                      text: 'Product Name',
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: descriptionController,
                      text: 'Description',
                      maxLines: 7,
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: priceController,
                      text: 'Price',
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: quantityController,
                      text: 'Quantity',
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: Category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: ((String? newVal) {
                          setState(() {
                            Category = newVal!;
                          });
                        }),
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                        text: 'Add',
                        onTap: () {
                          addProdcut();
                        }),
                  ],
                ),
              )),
        ));
  }
}
