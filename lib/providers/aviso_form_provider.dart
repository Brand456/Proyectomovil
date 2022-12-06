import 'package:flutter/material.dart';
import 'package:productos_app/models/Modelsgesaviso/models.dart';

class AvisoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Aviso product;

  AvisoFormProvider(this.product);

  bool isValidForm() {
    print(product.aviso);
    print(product.fecha);
    print(product.nombreaviso);
    return formKey.currentState?.validate() ?? false;
  }
}
