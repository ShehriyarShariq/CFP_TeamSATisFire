import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id, name, imageURL;

  Category({this.id, this.name, this.imageURL});

  factory Category.fromJson(Map<String, String> json) => Category(
        id: json['id'],
        name: json['name'],
        imageURL: json['imageURL'],
      );

  @override
  List<Object> get props => [id, name, imageURL];
}
