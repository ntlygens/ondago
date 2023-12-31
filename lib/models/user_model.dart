class UserModel {
  final String? gender;
  final String? title;
  final String? first;
  final String? last;
  final String? city;
  final String? state;
  final String? country;
  final String? postcode;
  final String? picture;
  final String? phone;

  const UserModel({
    this.title,
    this.city,
    this.country,
    this.first,
    this.gender,
    this.last,
    this.phone,
    this.picture,
    this.postcode,
    this.state,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'],
      title: json['name']['title'],
      first: json['name']['first'],
      last: json['name']['last'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'],
      picture: json['picture']['large'],
      phone: json['phone'],
    );
  }
}