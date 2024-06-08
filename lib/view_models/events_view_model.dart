import 'package:feast_mobile/models/category.dart';
import 'package:feast_mobile/models/event.dart';
import 'package:feast_mobile/services/http_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/filters.dart';

class EventViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Event> _eventList = [];
  late Event _selectedEvent;
  List<CategoryModel> _existingCategories = [];

  bool get loading => _loading;
  List<Event> get eventList => _eventList;
  List<CategoryModel> get existingCategories => _existingCategories;
  Event get selectedEvent => _selectedEvent;

  TextEditingController controller = TextEditingController();
  Filters _filters = Filters.empty();
  late Filters _filtersDup;
  String get startTime => _filtersDup.startTime.substring(1, 6);
  String get endTime => _filtersDup.endTime.substring(1, 6);
  String get startDate => _filtersDup.startDate;
  String get endDate => _filtersDup.endDate;
  List<CategoryModel> get filterCategories => _filtersDup.categories;

  createFiltersDup() {
    _filtersDup = _filters.copyWith();
  }

  bool filtersChanged(){
    return !listEquals(_filters.categories, _filtersDup.categories);
  }

  applyFiltersChanges(){
    _filters = _filtersDup.copyWith();
  }

  setFilterAge(int age) {
    _filtersDup.age = age;
  }

  addFilterCategory(CategoryModel newCategory) {
    _filtersDup.categories.add(newCategory);
    notifyListeners();
  }

  removeFilterCategory(CategoryModel category) {
    _filtersDup.categories.remove(category);
    notifyListeners();
  }

  setFilterStartTime(String startTime) {
    _filtersDup.startTime = '$startTime';
    notifyListeners();
  }

  setFilterEndTime(String endTime) {
    _filtersDup.endTime = '$endTime';
    notifyListeners();
  }

  setFiltersStartDate(String startDate) {
    _filtersDup.startDate = startDate;
    notifyListeners();
  }

  setFiltersEndDate(String endDate) {
    _filtersDup.endDate = endDate;
    notifyListeners();
  }

  EventViewModel() {
    getEvents();
    getCategories();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setEventList(List<Event> eventList) {
    _eventList = eventList;
  }

  setCategories(List<CategoryModel> categories) {
    _existingCategories = categories;
  }

  setSelectedEvent(Event selectedEvent) {
    _selectedEvent = selectedEvent;
  }

  getEvents() async {
    setLoading(true);
    try {
      setEventList(await HttpService.getEvents(_filters));
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  getCategories() async {
    setLoading(true);
    try {
      setCategories(await HttpService.getCategories());
    } catch (e) {
    } finally {
      setLoading(false);
    }
  }

  resetFilters() {
    _filtersDup.resetFilters();
    controller.text = '';
    notifyListeners();
  }
}
