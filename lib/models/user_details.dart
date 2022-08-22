class UserDetails {
  final int id;
  final String firstName, lastName, profileUrl;

  UserDetails(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.profileUrl =
          'https://cdn.pixabay.com/photo/2015/06/22/08/38/siblings-817369_960_720.jpg'});
  factory UserDetails.fromJson(Map<dynamic, dynamic> json) {
    return UserDetails(
      id: json['id'],
      firstName: json['name'],
      lastName: json['username'],
    );
  }
}
