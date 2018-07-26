import 'package:flutter/material.dart';
import 'package:recipe_app/Food.dart';
import 'package:recipe_app/foodDetail.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Scaffold with Flexible Header
    // Comment if you want normal header
    return Scaffold(body: ListHomeScreen(listFood: Food.mock()));

    // Normal Header
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text('Food Recipes'),
        backgroundColor: Theme.of(context).primaryColor
      ),
      body: ListHomeScreen(listFood: Food.mock()),
    );
  }
}

class ListHomeScreen extends StatelessWidget {
  final List<Food> listFood;

  // Construtor
  ListHomeScreen({Key key, @required this.listFood}) : super(key: key);

  // função que retorna um TextStyle para usar no texto
  TextStyle priceStyle() {
    return TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);
  }

  @override
  Widget build(BuildContext context) {

    // CustomScroll view with SliverAppbar
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 150.0,
          elevation: 2.0,
          forceElevated: true,
          leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.grid_on), onPressed: () => {}),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Food Recipes'),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return buildRow(context, listFood[index]);
          }, childCount: Food.mock().length),
        )
      ],
    );

    // Normal Listview
    return ListView.builder(
      itemCount: listFood.length,
      padding: EdgeInsets.all(12.0),
      itemBuilder: (context, index) {
        return buildRow(context, listFood[index]);
      },
    ); 
  }

  Widget buildRow(BuildContext context, Food food) {
    // retorna um GestureDetector, para detectar quando tem um toque nesta Cell
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            new MaterialPageRoute(
              builder: 
              (context) => FoodDetail(
                food: food,
              )
            )
          );
        },
        child: _foodCard(food)
        // S_04
    );
  }

  // FoodCard
  Widget _foodCard(Food food) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            _foodImage(food),
            _foodInfo(food)
          ],
        ),
      ),
    );
  }

  // FoodImage
  Widget _foodImage(Food food) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250.0),
      child: Hero(
        tag: 'pasta_image_${food.id}}',
        child: Image(
          image: AssetImage(food.imageName),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  // FoodInfo
  Widget _foodInfo(Food food) {
    return Container(
      height: 50.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Hero(
                tag: 'pasta_name_${food.id}}',
                child: Material(
                  color: Colors.transparent,
                  child: Text('${food.name}'),
                ),
              ))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Hero(
            tag: 'pasta_price_${food.id}}',
            child: Material(
              color: Colors.transparent,
              child: Text(
                '${food.price}',
                style: priceStyle(),
              ),
            ),
          )),
        ],
      ),
    );
  }

}
