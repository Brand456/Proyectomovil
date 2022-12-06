import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/models/Modelsgesaviso/models.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:productos_app/services/servicesGestion/services.dart';
import 'package:productos_app/services/servicesaviso/services.dart';
import 'package:productos_app/widgets/avisowidget/widgets.dart';

class Homeaviso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<AvisoService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Avisos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'homeprin');
          },
        ),
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  productsService.selectedProduct =
                      productsService.products[index].copy();
                  Navigator.pushNamed(context, 'avis');
                },
                child: ProductCard(
                  product: productsService.products[index],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = new Aviso(
            nombreaviso: '',
            fecha: '',
            aviso: '',
          );
          Navigator.pushNamed(context, 'avis');
        },
      ),
    );
  }
}
