import 'dart:convert';

import 'package:feast_mobile/models/route.dart';
import 'package:feast_mobile/models/route_info.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

abstract class RoutingService {
  static Future<RouteModel> getRouteFullFromAddress(
      String startAddress, String endAddress, RouteType type) async {
    final body;
    if (type == RouteType.walk)
      body = await rootBundle.loadString("assets/json/route_info_walk.json");
    else
      body = await rootBundle.loadString("assets/json/route_info_car.json");
    return RouteModel.fromJson(jsonDecode(body));
  }

  static Future<RouteModel> getRouteFullFromCoord(
      LatLng startAddress, String endAddress, RouteType type) async {
    final body;
    if (type == RouteType.walk)
      body = await rootBundle.loadString("assets/json/route_info_walk.json");
    else
      body = await rootBundle.loadString("assets/json/route_info_car.json");
    return RouteModel.fromJson(jsonDecode(body));
  }

  static Future<RouteModel> getRouteBasicFromAddress(
      String startAddress, String endAddress, RouteType type) async {
    final body;
    if (type == RouteType.walk)
      body =
          await rootBundle.loadString("assets/json/route_info_small_walk.json");
    else
      body =
          await rootBundle.loadString("assets/json/route_info_small_car.json");
    return RouteModel.fromJson(jsonDecode(body));
  }

  static Future<RouteModel> getRouteBasicFromCoord(
      LatLng startAddress, String endAddress, RouteType type) async {
    final body;
    if (type == RouteType.walk)
      body =
          await rootBundle.loadString("assets/json/route_info_small_walk.json");
    else
      body =
          await rootBundle.loadString("assets/json/route_info_small_car.json");
    return RouteModel.fromJson(jsonDecode(body));
  }
}
