import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/models/Modelsgestesis/models.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:productos_app/services/servicesGestion/services.dart';
import 'package:productos_app/widgets/Widgetsgestesis/widgets.dart';

class Homegestiontesista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de tesis'),
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  productsService.selectedProduct =
                      productsService.products[index].copy();
                },
                child: ProductCard(
                  product: productsService.products[index],
                ),
              )),
    );
  }
}
