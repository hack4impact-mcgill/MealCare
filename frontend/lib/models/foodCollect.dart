class FoodCollect {
  num id;
  String pickup_time;
  num vendor_id;

  FoodCollect({
    this.id,
    this.pickup_time,
    this.vendor_id,
  });

  FoodCollect.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        pickup_time = json['pickup_time'],
        vendor_id = json['vendor_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'vendor_id': vendor_id,
        'pickup_time': pickup_time,
      };
}
