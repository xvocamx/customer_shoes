class Cart {
  String? id;
  String? idShoes;
  String? nameShoes;
  int? size;
  double? price;
  int? quantity;
  String? image;

  Cart({
    this.id,
    this.idShoes,
    this.nameShoes,
    this.size,
    this.price,
    this.quantity,
    this.image,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idShoes = json['idShoes'],
        nameShoes = json['nameShoes'],
        size = json['size'],
        price = json['price'],
        quantity = json['quantity'] as int,
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'idShoes' : idShoes,
        'nameShoes': nameShoes,
        'size': size,
        'price': price,
        'quantity': quantity,
        'image': image,
      };
}
