import 'package:flutter/material.dart';
import 'package:recipe_app/Food.dart';

class FoodDetail extends StatelessWidget {
  final Food food;

  FoodDetail({Key key, @required this.food}) : super(key: key);

  TextStyle priceStyle() {
    return TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_foodImage(food), _foodCard(context, food)],
        ),
      ),
    );
  }

  Widget _foodImage(Food food) {
    return Container(
      child: new Hero(
        tag: 'pasta_image_${food.id}}',
        child: Image(
          height: 300.0,
          image: AssetImage(food.imageName),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _foodCard(BuildContext context, Food food) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          _foodMenu(context, food),
          Divider(),
          _foodDescription(food),
          _cartButton()
        ],
      ),
    );
  }

  Widget _foodMenu(BuildContext context, Food food) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: 'pasta_name_${food.id}}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(food.name),
                  ),
                ),
                Hero(
                  tag: 'pasta_price_${food.id}}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      '\$${food.price}',
                      style: priceStyle(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _foodDescription(Food food) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        food.description,
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w200, color: Colors.black54),
      ),
    );
  }

  Widget _cartButton() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        child: Container(
          height: 60.0,
          color: Colors.grey.shade900,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => {},
                color: Colors.white,
              ),
              Text('1',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0)),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => {},
                  color: Colors.white),
              Text('|',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Text('ADD TO CART',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
