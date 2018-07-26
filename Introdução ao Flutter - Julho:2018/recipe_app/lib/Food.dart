
class Food {
  int id;
  String name;
  String description;
  String imageName;
  double price;

  Food({
    this.id,
    this.name,
    this.description,
    this.imageName,
    this.price
  });

  static List<Food> mock() {
    return [
      Food(
        id: 0,
        name: 'Pasta One',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt, leo quis tempor blandit, neque sem pulvinar ligula, sit amet porta leo purus quis dolor. Maecenas dapibus est eros',
        imageName: 'assets/pasta_one.jpg',
        price: 50.0
      ),
      Food(
        id: 1,
        name: 'Pasta Two',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt, leo quis tempor blandit, neque sem pulvinar ligula, sit amet porta leo purus quis dolor. Maecenas dapibus est ',
        imageName: 'assets/pasta_two.jpg',
        price: 100.0
      ),
      Food(
        id: 2,
        name: 'Pasta Three',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt, leo quis tempor blandit, neque sem pulvinar ligula, sit amet porta leo purus quis dolor. Maecenas dapibus est eros',
        imageName: 'assets/pasta_one.jpg',
        price: 30.0
      ),
      Food(
        id: 3,
        name: 'Pasta Four',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tincidunt, leo quis tempor blandit, neque sem pulvinar ligula, sit amet porta leo purus quis dolor. Maecenas dapibus est eros',
        imageName: 'assets/pasta_two.jpg',
        price: 57.0
      )
    ];
  }
}