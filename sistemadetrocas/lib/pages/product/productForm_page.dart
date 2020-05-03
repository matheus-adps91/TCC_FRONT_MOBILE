import 'dart:io';
import 'dart:convert' as convert;

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

  // Armaze o caminho da foto. (até a pasta assets)
  File _file;

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
                child: _file != null ? Image.file(_file) : Image.asset("assets/images/camera.png", height: 300)),
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

    final String name = tProductName.text;
    final String description = tDescription.text;
    final String productCategory = dropdownValue.toString();
    final String image = _file != null ? _convertImageToBase64(_file) : 'Sem foto';
    final String imageName = _file != null ? path.basename(_file.path) : 'Sem nome';

    final Product product = Product(name,description, productCategory, base64Image: image, imageFileName: imageName);

    ApiEntityResponse apiResponse = await CrudProduct.create(product);

    AppAlert appAlert = AppAlert(
        apiResponse.actionMsg,
        apiResponse.textButton,
        context,
        apiResponse.status
    );
    appAlert.buildAlertCreatingProduct();
  }

  // Faz a conversão da imagem para base 64
  String _convertImageToBase64(File file) {
    final List<int> imageBytes = _file.readAsBytesSync();
     return convert.base64Encode(imageBytes);
  }

  // Inicializa a câmera do device
  void _onClickCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image);

    setState(() {
      _file = image;
    });
  }

  // Verifica se a categoria escolhida é diferente da default
  bool _hasNotEqualDefaultValue(String dropdownValue) {
    return dropdownValue.hashCode != ProductCategory.Categoria.hashCode ? true : false;
  }
}
