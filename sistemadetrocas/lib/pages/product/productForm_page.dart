import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/model/productCategory.dart';
import 'package:sistemadetrocas/requests/products/crudProduct_api.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_alert.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_formField.dart';
import 'package:sistemadetrocas/utils/validation.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  // Campo default do dropdownbutton
  String dropdownValue = ProductCategory.Categoria;

  // Variável global para armazenar o estado da aplicação
  final _formCreateProductKey = GlobalKey<FormState>();

  // Controllers para os campos do formulário de registro do produto
  final tProductName = TextEditingController();
  final tDescription = TextEditingController();

  // Armazena a foto
  File _photoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Produto'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formCreateProductKey,
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
        child: ListView(
          children: <Widget>[
            Center(
                child: Text('Tire uma foto', style: TextStyle(fontSize: 25),)),
            spaceBetweenElements(y: 15.0),
            Container(
                child: _photoFile != null ? Image.file(_photoFile) : Image.asset("assets/images/camera.png", height: 300)),
            spaceBetweenElements(y: 15.0),
            FloatingActionButton(
              onPressed: _onClickCamera,
              tooltip: 'Click para acionar a câmera',
              child: Icon(Icons.camera),
            ),
            spaceBetweenElements(y: 15.0),
            AppFormField(
              "Nome do Produto",
              tProductName,
              validator: validateEmptyField,
            ),
            spaceBetweenElements(y: 15.0),
            AppFormField(
              "Descrição do Produto",
              tDescription,
              validator: validateEmptyField,
            ),
            spaceBetweenElements(y: 15.0),
            buildDropdownButton(),
            spaceBetweenElements(y: 30.0),
            AppButton('Cadastrar', Colors.white, 22, Colors.blue,
                () => _onClickCreateProduct(context)),
            spaceBetweenElements(y: 30.0)
          ],
        ),
      ),
    );
  }

  // Constrói o Dropdown button da Categoria de Produto
  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black),
      onChanged: (String newProductCategory) {
        setState(() {
          dropdownValue = newProductCategory;
        });
      },
      items: ProductCategory.getAllProductCategories()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Espaço entre elementos do ListView do formulário de SignUp
  SizedBox spaceBetweenElements({double y = 0, double x = 0}) {
    return SizedBox(height: y, width: x);
  }

  // Delega para o arquivo de validações
  String validateEmptyField(String value) {
    return Validation.defaultValidation(value);
  }

  void _onClickCreateProduct(BuildContext context) async {
    print('>>> FUNÇÃO: _onClickCreateProduct');
    final bool formRespValidation = _formCreateProductKey.currentState.validate();
    print(formRespValidation);

    if (!formRespValidation) {
      return;
    }
    if ( !_hasNotEqualDefaultValue(dropdownValue.toString())){
      return;
    }

    String imagePathFromStorage = await _uploadImageToStorage();
    final String name = tProductName.text;
    final String description = tDescription.text;
    final String productCategory = dropdownValue.toString();
    final String imagePath =  imagePathFromStorage;

    final Product product = Product(
        name,
        description,
        productCategory,
        imagePath: imagePath
    );

    ApiEntityResponse apiResponse = await CrudProduct.create(product);

    AppAlert appAlert = AppAlert(
        apiResponse.actionMsg,
        apiResponse.textButton,
        context,
        apiResponse.status
    );
    appAlert.buildAlertCreatingProduct();
  }


   Future<String> _uploadImageToStorage() async {

    StorageTaskSnapshot futureTaskSnapshot = await _upload();
    String downloadURL = await futureTaskSnapshot.ref.getPath();
    return downloadURL;
  }

  Future<StorageTaskSnapshot> _upload() async {
    final StorageReference fbStorageRef = FirebaseStorage.instance
        .ref()
        .child(_photoFile.path);
    final StorageUploadTask task = fbStorageRef.putFile(_photoFile);
    var futureTaskSnapshot = await task.onComplete;
    return futureTaskSnapshot;
  }


  // Inicializa a câmera do device
  void _onClickCamera() async {
      File image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _photoFile = image;
    });
  }

  // Verifica se a categoria escolhida é diferente da default
  bool _hasNotEqualDefaultValue(String dropdownValue) {
    return dropdownValue.hashCode != ProductCategory.Categoria.hashCode ? true : false;
  }
}
