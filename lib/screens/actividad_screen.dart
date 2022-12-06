import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:productos_app/providers/activity_form_provider.dart';

import 'package:productos_app/services/servicesActi/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/Widgetsgestesis/widgets.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ActivityService>(context);

    return ChangeNotifierProvider(
      create: (_) => ActivityFormProvider(productService.selectedProduct),
      child: _ActivityScreenBody(productService: productService),
    );
  }
}

class _ActivityScreenBody extends StatelessWidget {
  const _ActivityScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ActivityService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ActivityFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back_ios_new,
                          size: 40, color: Colors.white),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        final picker = new ImagePicker();
                        final PickedFile? pickedFile = await picker.getImage(
                            // source: ImageSource.gallery,
                            source: ImageSource.camera,
                            imageQuality: 100);

                        if (pickedFile == null) {
                          print('No seleccionó nada');
                          return;
                        }

                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    ))
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productService.isSaving
            ? CircularProgressIndicator(color: Colors.white)
            : Icon(Icons.save_outlined),
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;

                final String? imageUrl = await productService.uploadImage();

                if (imageUrl != null) productForm.product.picture = imageUrl;

                await productService.saveOrCreateProduct(productForm.product);
              },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ActivityFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.nombreactividad,
                onChanged: (value) => product.nombreactividad = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre de la actividad',
                    labelText: 'Nombre de la actividad:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.entregableindi,
                onChanged: (value) => product.entregableindi = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'ingresar las lineas';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Lineas de investigacion',
                    labelText: 'Lineas de investigacion:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.fechadeinicio,
                onChanged: (value) => product.fechadeinicio = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'ingresar la fecha';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Fecha de inicio', labelText: 'Fecha:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.fechadefin,
                onChanged: (value) => product.fechadefin = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Ingresa la fecha final';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'fecha final', labelText: 'fecha:'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
