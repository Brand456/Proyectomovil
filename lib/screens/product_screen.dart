import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:productos_app/services/servicesGestion/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/Widgetsgestesis/widgets.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

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
    final productForm = Provider.of<ProductFormProvider>(context);
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
                initialValue: product.nametesis,
                onChanged: (value) => product.nametesis = value,
                validator: (value) {
                  var db = FirebaseFirestore.instance;
                  db
                      .collection("Gestionartesis")
                      .where("nametesis", isEqualTo: value)
                      .get()
                      .then(
                        (res) => print("Ya existe un registro de tesis"),
                        onError: (e) => print("Error completing: $e"),
                      );
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre de la tesis',
                    labelText: 'Nombre de la tesis:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.lineasdeinvestigacion,
                onChanged: (value) => product.lineasdeinvestigacion = value,
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
                initialValue: product.nameasesor,
                onChanged: (value) => product.nameasesor = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Ingresa el nombre del asesor';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del asesor', labelText: 'Asesor:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.nametesista,
                onChanged: (value) => product.nametesista = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Ingresa el nombre';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del tesista', labelText: 'Tesista:'),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.matricula}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.matricula = 0;
                  } else {
                    product.matricula = double.parse(value) as int;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '\201750456', labelText: 'Matricula:'),
              ),
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.correo,
                onChanged: (value) => product.correo = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Ingresa el correo';
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del correo', labelText: 'Correo:'),
              ),
              SizedBox(height: 30)
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
