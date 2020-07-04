import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sistemadetrocas/infrastructure/api_entityResponse.dart';
import 'package:sistemadetrocas/model/product.dart';
import 'package:sistemadetrocas/model/productCategory.dart';
import 'package:sistemadetrocas/pages/home_page.dart';
import 'package:sistemadetrocas/requests/products/crudProduct_api.dart';
import 'package:sistemadetrocas/requests/storage/fire_storage_service.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_alert.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_button.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_confirmOperation.dart';
import 'package:sistemadetrocas/utils/composedWidgets/app_formField.dart';
import 'package:sistemadetrocas/utils/nav.dart';
import 'package:sistemadetrocas/utils/validation.dart';

class CreateProduct extends StatefulWidget {
  final Product updatedProduct;
  final bool update;
  CreateProduct({this.updatedProduct, this.update = false});

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  // Campo default do dropdownbutton
  String dropdownValue = ProductCategory.Categoria;

  // Variável global para armazenar o estado da aplicação
  final _formCreateProductKey = GlobalKey<FormState>();

  // Controllers para os campos do formulário de registro do produto
  TextEditingController tProductName = TextEditingController();
  TextEditingController tDescription = TextEditingController();

  // Armazena a foto
  File _photoFile;
  // Cachea o field nome, vai ser passado na URL, para a busca do produto no back
  String _cacheProductName;
  // Cachea a foto, verificação de atualizaçãod e foto
  String _cacheImgPath;
  // Armazena o caminho da foto para o fireStorage
  String _imagePathFromStorage;
  // Auxiliar Get para recuperar o produto
  Product get gUpdatedProduct => widget.updatedProduct;
  // Auxiliar Get para verificar se é atualização
  bool get isUpdate => widget.update;

  @override
  void initState() {
    super.initState();

    if (gUpdatedProduct != null) {
      this.tProductName.text = gUpdatedProduct.gName;
      this.tDescription.text = gUpdatedProduct.gDesc;
      this.dropdownValue = gUpdatedProduct.gProdCat;
      _cacheProductName = gUpdatedProduct.gName;
      _cacheImgPath = gUpdatedProduct.gImgPath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle())),
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
                child: Text (_getPhotoTitle(),
                  style: TextStyle(fontSize: 25),
                )),
            spaceBetweenElements(y: 15.0),
            Container(child: _getImage()),
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
            Center(child: buildDropdownButton()),
            spaceBetweenElements(y: 30.0),
            AppButton(_getButtonName(), Colors.white, 22, Colors.blue, () {
              _createOrUpdateProduct();
              }
            ),
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

  void _createOrUpdateProduct() {
    if ( isUpdate ) {
      _onClickUpdatedProduct(context);
    } else {
      _onClickCreateProduct(context);
    }
  }

  void _onClickCreateProduct(BuildContext context) async {
    print('>>> FUNÇÃO: _onClickCreateProduct');
    final bool formRespValidation =
    _formCreateProductKey.currentState.validate();
    print(formRespValidation);

    if (!formRespValidation) {
      return;
    }
    if (!_hasNotEqualDefaultValue(dropdownValue.toString())) {
      return;
    }

    // Se o usuário tirou a foto do produto, faz upload
    // Senão seta a imagem padrão
    if (_photoFile != null) {
      _imagePathFromStorage = await FireStorageService.uploadImageToStorage(_photoFile);
    } else {
      _imagePathFromStorage = 'assets/images/sem_foto.jpeg';
    }

    final String name = tProductName.text;
    final String description = tDescription.text;
    final String productCategory = dropdownValue.toString();
    final String imagePath = _imagePathFromStorage;

    final Product product = Product(name, description, productCategory, false, imagePath);

    ApiEntityResponse apiResponse = await CrudProduct.create(product);

    AppAlert appAlert = AppAlert(apiResponse.actionMsg, apiResponse.textButton,
        context, apiResponse.status);
    appAlert.buildAlertCreatingProduct();
  }

  _onClickUpdatedProduct(BuildContext context) async {
    print('>>> FUNÇÃO: _onClickUpdatedProduct');
    var appConfirmOperation = AppConfirmOperation(
        'Atualizar',
        'Confirmar a atualização do produto?',
        context);
    final bool shouldUpdate = await appConfirmOperation.buildAlertConfirm();
    if (!shouldUpdate) {
      return;
    }

    final bool formRespValidation =
    _formCreateProductKey.currentState.validate();
    print(formRespValidation);

    if (!formRespValidation) {
      return;
    }
    if (!_hasNotEqualDefaultValue(dropdownValue.toString())) {
      return;
    }

    // Se o nome de _photFile for diferente de _cachePhotoName
    // Fazer o upload da nova foto e deletar a velha
    if ( _photoFile != null && _cacheImgPath != _photoFile.path ) {
      print ('foto atualizada');
      _imagePathFromStorage = await FireStorageService.uploadImageToStorage(_photoFile);
    } else {
      print ('foto não atualizada');
      _imagePathFromStorage = _cacheImgPath;
    }

    final String name = tProductName.text;
    final String description = tDescription.text;
    final String productCategory = dropdownValue.toString();
    final Product product = Product(name, description, productCategory, false, _imagePathFromStorage);

    CrudProduct.updateProduct(product, _cacheProductName, _cacheImgPath);
    push(context, HomePage(), replace: true);
  }

  // Verifica se a categoria escolhida é diferente da default
  bool _hasNotEqualDefaultValue(String dropdownValue) {
    return dropdownValue.hashCode != ProductCategory.Categoria.hashCode
        ? true : false;
  }

  // Inicializa a câmera do device
  void _onClickCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _photoFile = image;
    });
  }

  // Lógica para ver qual imagem será exibida na tela
  Image _getImage() {
    if (gUpdatedProduct != null) {
      if (_photoFile != null ) {
        return Image.file(_photoFile);
      }
      return Image.network( gUpdatedProduct.gImgPath );
    }
    if ( _photoFile != null ) {
      return Image.file(_photoFile);
    }
    return Image.asset("assets/images/camera.png", height: 300);
  }

   String _getAppBarTitle() {
    return isUpdate ? 'Atualizar Produto' : 'Cadastrar Produto';
  }

  String _getPhotoTitle() {
    return isUpdate ? 'Atualize a foto' : 'Tire uma foto';
  }

  String _getButtonName() {
    return isUpdate ? 'Atualizar' : 'Cadastrar';
  }

}
