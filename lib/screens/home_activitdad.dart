import 'package:flutter/material.dart';
import 'package:productos_app/models/Modelsgesactivi/gestionactividad.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/models/Modelsgesactivi/models.dart';
import 'package:productos_app/screens/screens.dart';

import 'package:productos_app/services/servicesGestion/services.dart';
import 'package:productos_app/services/servicesActi/services.dart';

import 'package:productos_app/widgets/Widgetsgestactivi/widgets.dart';

class Homeactivi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ActivityService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades'),
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
                  Navigator.pushNamed(context, 'tareas');
                },
                child: ProductCard(
                  product: productsService.products[index],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = new Act(
            nombreactividad: '',
            fechadefin: '',
            entregableindi: '',
            fechadeinicio: '',
          );
          Navigator.pushNamed(context, 'tareas');
        },
      ),
    );
  }
}
