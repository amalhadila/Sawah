class UserCartResponse {
  String status;
  int numOfCartItems;
  Data data;

  UserCartResponse({
    required this.status,
    required this.numOfCartItems,
    required this.data,
  });

  factory UserCartResponse.fromJson(Map<String, dynamic> json) =>
      UserCartResponse(
        status: json["status"],
        numOfCartItems: json["numOfCartItems"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "numOfCartItems": numOfCartItems,
        "data": data.toJson(),
      };
}

class Data {
  Cart cart;

  Data({
    required this.cart,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cart: Cart.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "cart": cart.toJson(),
      };
}

class Cart {
  String id;
  List<CartItem> cartItems;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int totalCartPrice;

  Cart({
    required this.id,
    required this.cartItems,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.totalCartPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromJson(x))),
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        totalCartPrice: json["totalCartPrice"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "totalCartPrice": totalCartPrice,
      };
}

class CartItem {
  Tour tour;
  int groupSize;
  int itemPrice;
  DateTime tourDate;
  String id;

  CartItem({
    required this.tour,
    required this.groupSize,
    required this.itemPrice,
    required this.tourDate,
    required this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        tour: Tour.fromJson(json["tour"]),
        groupSize: json["groupSize"],
        itemPrice: json["itemPrice"],
        tourDate: DateTime.parse(json["tourDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "tour": tour.toJson(),
        "groupSize": groupSize,
        "itemPrice": itemPrice,
        "tourDate": tourDate.toIso8601String(),
        "_id": id,
      };
}

class Tour {
  String id;
  String name;
  int duration;
  List<String> images;
  int price;
  String guide;
  String tourId;

  Tour({
    required this.id,
    required this.name,
    required this.duration,
    required this.images,
    required this.price,
    required this.guide,
    required this.tourId,
  });

  factory Tour.fromJson(Map<String, dynamic> json) => Tour(
        id: json["_id"],
        name: json["name"],
        duration: json["duration"],
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        guide: json["guide"],
        tourId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "duration": duration,
        "images": List<dynamic>.from(images.map((x) => x)),
        "price": price,
        "guide": guide,
        "id": tourId,
      };
}
