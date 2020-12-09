import 'package:equatable/equatable.dart';
import 'package:satisfire_hackathon/features/all_categories/data/models/category.dart';
import 'package:satisfire_hackathon/features/service_details/data/models/review.dart';

class Service extends Equatable {
  final String id, providerID, title, description, type;
  final List<String> images;
  final int price, ranking;
  final Category category;
  List<Review> reviews;
  double rating;

  Service({
    this.id,
    this.providerID,
    this.title,
    this.description,
    this.type,
    this.images,
    this.price,
    this.ranking,
    this.category,
    this.reviews,
    this.rating,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'],
        providerID: json['provider_id'],
        title: json['title'],
        description: json['description'],
        type: json['type'],
        images: List<String>.from(json['images']),
        price: int.parse(json['price'].toString()),
        ranking: int.parse(json['ranking'].toString()),
        category: Category.fromJson(Map<String, String>.from(json['category'])),
      );

  @override
  List<Object> get props => [
        id,
        providerID,
        title,
        description,
        type,
        images,
        price,
        ranking,
        category,
        reviews,
        rating,
      ];
}
