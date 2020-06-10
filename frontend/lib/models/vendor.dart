class Vendor {
  String name;
  num id;
  String city;
  String address;

  Vendor({
    this.name,
    this.id,
    this.city,
    this.address,
  });

  Vendor.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        city = json['city'],
        address = json['address'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'city': city,
      };
}
