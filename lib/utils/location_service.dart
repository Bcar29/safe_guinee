import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class LocationService {
  Location location = Location();

  Future<LocationData?> getLocationUser() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      return await location.getLocation();
    } catch (e) {
      print("erreur $e");
    }
    return null;
  }

  Future<String?> getAddresseFromCoordinates() async {
    final position = await getLocationUser();
    if (position == null ||
        position.latitude == null ||
        position.longitude == null) {
      return "Inconnu";
    }
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude!,
        position.longitude!,
      );
      if (placemarks.isEmpty) {
        return "Impossible de trouver l'addresse";
      }

      final placemark = placemarks.first;

      final adresseLisible =
          "${placemark.name}, "
          "${placemark.street}, "
          "${placemark.locality}, "
          "${placemark.administrativeArea}, ";

      print("latitue : ${position.latitude}");
      print("longitude : ${position.longitude}");

      // const apiKey = "3fffac7942974476a36dcf06c19b4e5a";
      // final url = Uri.parse(url)
      return adresseLisible;
    } catch (e) {}
    return null;
  }
}
