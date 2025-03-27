class Superhero {
  final String name;
  final String imageUrl;
  final String id;

  Superhero({
    required this.name,
    required this.imageUrl,
    required this.id,
  });
}

List<Superhero> superheroes = [
  Superhero(
    name: "Iron-Man",
    imageUrl: "assets/images/superheroes/iron.jpg",
    id: "1",
  ),
  Superhero(
    name: "Spider-Man",
    imageUrl: "assets/images/superheroes/spider.webp",
    id: "2",
  ),
  Superhero(
    name: "Captain America",
    imageUrl: "assets/images/superheroes/captain.jpg",
    id: "3",
  ),
  Superhero(
    name: "Thor",
    imageUrl: "assets/images/superheroes/thor.jpeg",
    id: "4",
  ),
  Superhero(
    name: "Scarlet",
    imageUrl: "assets/images/superheroes/scarlet.webp",
    id: "5",
  ),
  Superhero(
    name: "Black Panther",
    imageUrl: "assets/images/superheroes/panther.webp",
    id: "6",
  ),
  Superhero(
    name: "Hulk",
    imageUrl: "assets/images/superheroes/hulk.webp",
    id: "7",
  ),
  Superhero(
    name: "Black Widow",
    imageUrl: "assets/images/superheroes/black.jpg",
    id: "8",
  ),
  Superhero(
    name: "Doctor Strange",
    imageUrl: "assets/images/superheroes/doctor.jpeg",
    id: "9",
  ),
  Superhero(
    name: "Ant-Man",
    imageUrl: "assets/images/superheroes/ant.webp",
    id: "10",
  ),
];
