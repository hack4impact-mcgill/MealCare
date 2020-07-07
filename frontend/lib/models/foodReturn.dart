class FoodRerturn {
  num id;
  String return_time;
  num vendor_id;

  FoodRerturn({
    this.id,
    this.return_time,
    this.vendor_id,
  });

  FoodRerturn.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        return_time = json['return_time'],
        vendor_id = json['vendor_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'vendor_id': vendor_id,
        'pickup_time': return_time,
      };
}
