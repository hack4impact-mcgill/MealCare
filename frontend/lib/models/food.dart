class Food {
  String name;
  double weight;
  String date_produced;
  String expiry_date;
  String description;
  String category;
  String serving_size;

  Food(
      {this.name,
      this.weight,
      this.date_produced,
      this.expiry_date,
      this.description,
      this.category,
      this.serving_size});

  Food.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        weight = json['weight'],
        date_produced = json['date_produced'],
        expiry_date = json['expiry_date'],
        description = json['description'],
        category = json['category'],
        serving_size = json['serving_size'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'weight': weight,
        'date_produced': date_produced,
        'expiry_date': expiry_date,
        'description': description,
        'category': category,
        'serving_size': serving_size
      };
}
