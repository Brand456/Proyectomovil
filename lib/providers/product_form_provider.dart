import 'package:flutter/material.dart';
import 'package:productos_app/models/Modelsgestesis/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Tesis product;

  ProductFormProvider(this.product);

  bool isValidForm() {
    print(product.correo);
    print(product.fechadeinicio);
    print(product.lineasdeinvestigacion);
    print(product.nameasesor);
    print(product.nametesis);
    print(product.nametesista);
    print(product.matricula);
    return formKey.currentState?.validate() ?? false;
  }
}
