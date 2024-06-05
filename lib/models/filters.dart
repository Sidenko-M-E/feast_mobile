import 'package:feast_mobile_email/models/category.dart';


class Filters {
  int age;
  List<CategoryModel> categories;
  String startTime;
  String endTime;
  String startDate;
  String endDate;

  String get start => '${startDate}${startTime}';
  String get end => '${endDate}${endTime}';

  resetFilters() {
    categories.clear();
    startTime = 'T00:00:00Z';
    endTime = 'T00:00:00Z';
    startDate = '2025-01-01';
    endDate = '2029-01-01';
    age = 100;
  }

  Filters(this.age, this.categories, this.startTime, this.endTime,
      this.startDate, this.endDate);

  Filters.empty()
      : age = 100,
        categories = [],
        startTime = 'T00:00:00Z',
        endTime = 'T00:00:00Z',
        startDate = '2025-01-01',
        endDate = '2029-01-01';

  Filters copyWith({
    int? age,
    List<CategoryModel>? categories,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
  }) {
    return Filters(
      age ?? this.age,
      categories ?? List.from(this.categories),
      startTime ?? this.startTime,
      endTime ?? this.endTime,
      startDate ?? this.startDate,
      endDate ?? this.endDate,
    );
  }

  // @override
  // bool operator ==(Object other) {
  //   return other is Filters &&
  //       other.age == age &&
  //       other.startTime == startTime &&
  //       other.endTime == endTime &&
  //       other.startDate == startDate &&
  //       other.endDate == endDate &&
  //       DeepCollectionEquality().equals(other.categories, categories);
  // }
}
