class Shoes {
  String? maSoGiay;
  final String tenGiay;
  final String loaiGiay;
  final double price;
  final int soLuong;
  String? images;

  //Constructor
  Shoes({
    this.maSoGiay,
    required this.tenGiay,
    required this.loaiGiay,
    required this.price,
    required this.soLuong,
    this.images,
  });

   Shoes.fromJson(Map<String, dynamic> json)
      : maSoGiay = json['maSoGiay'],
        tenGiay = json['tenGiay'],
        loaiGiay = json['loaiGiay'],
        price = json['price'],
        soLuong = json['soLuong'],
        images = json['images'];

  Map<String, dynamic> toJson() => {
    'maSoGiay': maSoGiay,
    'tenGiay' : tenGiay,
    'loaiGiay': loaiGiay,
    'price': price,
    'soLuong': soLuong,
    'images': images,
  };
}
