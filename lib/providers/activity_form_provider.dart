import 'package:flutter/material.dart';
import 'package:productos_app/models/Modelsgesactivi/gestionactividad.dart';

class ActivityFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Act product;

  ActivityFormProvider(this.product);

  bool isValidForm() {
    print(product.fechadefin);
    print(product.fechadeinicio);
    print(product.entregableindi);
    print(product.fechadefin);
    return formKey.currentState?.validate() ?? false;
  }
}
