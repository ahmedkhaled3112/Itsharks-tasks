import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product.dart';
import '../../logic/blocs/products_bloc/product_bloc.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  UserProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                try {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(DeleteProduct(product.id!));
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text('Delete has ocuured!'),
                    ),
                  );
                } catch (_) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text('Delete has Failed!'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
