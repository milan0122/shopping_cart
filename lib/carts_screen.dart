import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopping_cart/cart_provider.dart';
import 'package:shopping_cart/Models/cart_model.dart';
import 'package:shopping_cart/db_helper.dart';
class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  @override
  DBHelper? dbHelper = DBHelper();

  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Products')),
        backgroundColor: Colors.white,
        actions: [
          badges.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context,value,child){
                return Text(value.getItem().toString(),
                  style: TextStyle(color: Colors.white),);
              },

            ),
            onTap: () {},
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
          FutureBuilder(
              future: cart.getData(),
              builder:(context, AsyncSnapshot<List<Cart>> snapshot){
                if(snapshot.hasData){
                  return Expanded(child: ListView.builder(
                      itemCount: snapshot.data!.length,
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
                                      image: NetworkImage(snapshot.data![index].image.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data![index].productName.toString(),style: TextStyle(
                                                  fontSize: 16,fontWeight: FontWeight.w500
                                              ),),
                                              InkWell(
                                                onTap: (){
                                                  dbHelper!.delete(snapshot.data![index].id!);
                                                  cart.removeItem();
                                                  cart.removeTotalPrice(snapshot.data![index].productPrice!.toDouble());
                                                },
                                                  child: Icon(Icons.delete)),
                                            ],
                                          ),

                                          SizedBox(height: 5,),
                                          Text(snapshot.data![index].unit.toString() + " "+r'Rs' + snapshot.data![index].productPrice.toString(),style: TextStyle(
                                              fontSize: 16,fontWeight: FontWeight.w500
                                          ),),
                                          SizedBox(height: 10,),
                                          // Align(
                                          //   alignment: Alignment.topRight,
                                          //   child: InkWell(
                                          //     onTap: (){
                                          //     },
                                          //     child: Container(
                                          //       height: 30,
                                          //       width: 100,
                                          //       decoration: BoxDecoration(
                                          //           color: Colors.green,
                                          //           borderRadius: BorderRadius.circular(5)
                                          //       ),
                                          //       child: Padding(
                                          //         padding: const EdgeInsets.all(2.0),
                                          //         child: Row(
                                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //
                                          //           children: [
                                          //             Icon(Icons.add,color: Colors.white,),
                                          //             Text(snapshot.data![index].quantity.toString(),style: TextStyle(color: Colors.white),),
                                          //             InkWell(
                                          //               onTap: (){},
                                          //                 child: Icon(Icons.remove,color: Colors.white)),
                                          //           ],
                                          //
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    )


                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }));
                }
                else{
                  return Text('');
                }


          }),
          Consumer<CartProvider>(builder: (context,value,child){
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2)=='0.00' ? false:true,
              child: Column(
                children: [
                  ReusableWidget(title: 'Sub Total', value: r'Rs. '+value.getTotalPrice().toStringAsFixed(2),)
                ],
              ),
            );
          })

        ],
      ),

    );
  }
}
class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({ required this.title,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text(value, style: TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}

