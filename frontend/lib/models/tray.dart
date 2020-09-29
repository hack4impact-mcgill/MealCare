class Tray {
  int id;
  String type;
  int vendor;
  int tray_collect_id;
  int tray_return_id;
  String description;
  String date_acquired;

  Tray(
      {this.id,
      this.type,
      this.vendor,
      this.tray_collect_id,
      this.tray_return_id,
      this.description,
      this.date_acquired});

  Tray.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        vendor = json['vendor'],
        tray_collect_id = json['tray_collect_id'],
        tray_return_id = json['tray_return_id'],
        description = json['description'],
        date_acquired = json['date_acquired'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'vendor': vendor,
        'tray_collect_id': tray_collect_id,
        'tray_return_id': tray_return_id,
        'description': description,
        'date_acquired': date_acquired
      };
}
