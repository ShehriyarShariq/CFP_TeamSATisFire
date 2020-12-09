import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String message;
  final DateTime timestamp;
  final int rating;

  Review({this.message, this.timestamp, this.rating});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        message: json['message'],
        timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
        rating: json['rating'],
      );

  @override
  List<Object> get props => [message, timestamp, rating];
}
