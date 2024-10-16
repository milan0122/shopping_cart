import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping_cart/Models/cart_model.dart';
import 'package:shopping_cart/cart_provider.dart';
import 'package:shopping_cart/carts_screen.dart';
import 'package:shopping_cart/db_helper.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override


  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = ['Apple', 'Orange','Lemon','cherry','Banana','Dragon Fruit','Strawberry','Pear','Mixed Fruit Basket'];
  List<String> productUnit = ['KG','KG','kG','KG','Dozen','kG','KG','kG','KG'];

  List<int> productPrice = [250,150,400,500,100,500,1000,200,850];

  List<String> productImage = [
    'https://images.pexels.com/photos/209439/pexels-photo-209439.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/2294477/pexels-photo-2294477.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/129574/pexels-photo-129574.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/161582/mouth-watering-cherries-mouth-watering-mature-sweet-161582.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/7194915/pexels-photo-7194915.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/5945763/pexels-photo-5945763.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1028435/pexels-photo-1028435.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/28872580/pexels-photo-28872580/free-photo-of-rustic-wooden-bowl-of-fresh-pears.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://media.istockphoto.com/id/1395793331/photo/fresh-fruit-and-berries.jpg?b=1&s=612x612&w=0&k=20&c=lF2pi2-VRz8du9pUxyC64XL0QgvF_bE9uFZIzPtFSGo='
  ];


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Product List')),
        backgroundColor: Colors.white,
        actions: [
          badges.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context,value,child){
                return Text(value.getItem().toString(),
                  style: TextStyle(color: Colors.white),);
              },

            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (_)=>CartsScreen()) );
            },
            badgeAnimation: badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 3)),
            child: Icon(Icons.shopping_cart),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: productName.length,
              itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image(
                          height: 100,
                          width: 100,
                          image: NetworkImage(productImage[index].toString()),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productName[index].toString(),style: TextStyle(
                                  fontSize: 16,fontWeight: FontWeight.w500
                              ),),
                              SizedBox(height: 5,),
                              Text(productUnit[index].toString() + " "+r'Rs' + productPrice[index].toString(),style: TextStyle(
                                  fontSize: 16,fontWeight: FontWeight.w500
                              ),),
                              SizedBox(height: 10,),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: (){
                                    try{
                                      dbHelper!.insert(
                                          Cart(id: index,
                                            productId: index.toString(),
                                            productName: productName[index].toString(),
                                            initialPrice: productPrice[index],
                                            productPrice:productPrice[index],
                                            quantity: 1,
                                            unit: productUnit[index].toString(),
                                            image: productImage[index].toString(),
                                          )
                                      );
                                      cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                      cart.addItem();
                                      print('Product is added to cart');
                                    }
                                    catch(error)
                                    {
                                      print(error.toString());
                                    }

                                  },
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Text('Add to cart',style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )


                      ],
                    )
                  ],
                ),
              ),
            );
          })),

        ],
      ),
    );
  }
}
