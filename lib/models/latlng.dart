class LatLng {
  double latitude;
  double longitude;

  LatLng(this.latitude, this.longitude);

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
