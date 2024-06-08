import 'package:feast_mobile/models/category.dart';
import 'package:feast_mobile/models/place.dart';

class Event {
  final int id;
  final String name;
  final String description;
  final String startTime;
  final String endTime;
  final int ageLimit;
  final bool canceled;
  final Place place;
  final List<CategoryModel> categories;
  final List<String> imageUrls;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.ageLimit,
    required this.canceled,
    required this.place,
    required this.categories,
    required this.imageUrls,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final description = json['description'] as String;
    final startTime = json['startTime'] as String;
    final endTime = json['endTime'] as String;
    final ageLimit = json['ageLimit'] as int;
    final canceled = json['canceled'] as bool;
    final Place place = Place.fromJson(json['place'] as Map<String, dynamic>);
    final categoriesJson = json['categories'] as List<dynamic>?;
    final categories = categoriesJson != null
        ? categoriesJson
            .map((model) => CategoryModel.fromJson(model as Map<String, dynamic>))
            .toList()
        : <CategoryModel>[];
    final imageUrls = List<String>.from((json['imageUrls'] as List)
        .map((e) => e.replaceAll('localhost', '10.0.2.2')));

    return Event(
      id: id,
      name: name,
      description: description,
      startTime: startTime,
      endTime: endTime,
      ageLimit: ageLimit,
      canceled: canceled,
      place: place,
      categories: categories,
      imageUrls: imageUrls,
    );
  }
}
