class ParkingLocation {
  final String name;
  final String address;
  final String contactNumber;
  final double perHourCost;

  ParkingLocation({
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.perHourCost,
  });

  factory ParkingLocation.fromJson(Map<String, dynamic> json) {
    return ParkingLocation(
      name: json['name'],
      address: json['address'],
      contactNumber: json['contact_number'],
      perHourCost: json['per_hour_cost'].toDouble(),
    );
  }
}
