import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/models/Modelstarea/models.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:productos_app/services/servicesTarea/services.dart';
import 'package:productos_app/widgets/Productowidget/widgets.dart';

class LookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<TareaService>(context);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea de alumnos'),
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  productsService.selectedProduct =
                      productsService.products[index].copy();
                  Navigator.pushNamed(context, 'tarea');
                },
                child: ProductCard(
                  product: productsService.products[index],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              new Product(available: false, name: '', actividad: '');
          Navigator.pushNamed(context, 'tarea');
        },
      ),
    );
  }
}
