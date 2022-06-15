class Customer {
  final String uid;
  final String name;
  final String email;
  final String address;
  final String phone;
  final bool lockAccount;

  const Customer({
      required this.uid,
      required this.name,
      required this.email,
      required this.address,
      required this.phone,
      required this.lockAccount,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        address: json['address'],
        phone: json['phone'],
        lockAccount: json['lockAccount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'name' : name,
    'email' : email,
    'address' : address,
    'phone' : phone,
    'lockAccount' : lockAccount,
  };
}
