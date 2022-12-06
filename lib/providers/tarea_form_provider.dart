import 'package:flutter/material.dart';
import 'package:productos_app/models/Modelstarea/models.dart';

class TareaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  TareaFormProvider(this.product);

  updateAvailability(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.actividad);
    print(product.available);

    return formKey.currentState?.validate() ?? false;
  }
}
