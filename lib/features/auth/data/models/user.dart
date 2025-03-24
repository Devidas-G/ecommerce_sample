class User {
  final int? id; // Optional, as it will be null for new users
  final String fullName;
  final String phoneNumber;
  final String email;
  final String address;
  final String username;
  final String password;
  final String? token;

  User({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.username,
    required this.password,
    this.token,
  });

  // Factory constructor to create a User from JSON (for API responses)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: '${json['name']['firstname']} ${json['name']['lastname']}',
      phoneNumber: json['phone'],
      email: json['email'],
      address:
          '${json['address']['number']} ${json['address']['street']}, ${json['address']['city']}, ${json['address']['zipcode']}',
      username: json['username'],
      password: json['password'],
      token: json['token'],
    );
  }

  // Method to convert User to JSON (for API requests)
  Map<String, dynamic> toJson() {
    // Split fullName into first and last names (simple split for demo purposes)
    final nameParts = fullName.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // Split address into components (simple split for demo purposes)
    final addressParts = address.split(', ');
    final streetNumber =
        addressParts.isNotEmpty ? addressParts[0].split(' ')[0] : '0';
    final street =
        addressParts.isNotEmpty
            ? addressParts[0].split(' ').sublist(1).join(' ')
            : '';
    final city = addressParts.length > 1 ? addressParts[1] : '';
    final zipcode = addressParts.length > 2 ? addressParts[2] : '';

    return {
      'email': email,
      'username': username,
      'password': password,
      'name': {'firstname': firstName, 'lastname': lastName},
      'address': {
        'city': city,
        'street': street,
        'number': int.tryParse(streetNumber) ?? 0,
        'zipcode': zipcode,
        'geolocation': {
          'lat': '0.0', // Fake Store API requires this, but we don't have it
          'long': '0.0',
        },
      },
      'phone': phoneNumber,
      'token': token,
    };
  }

  User copyWithToken(String? newToken) {
    return User(
      id: id,
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      username: username,
      password: password,
      token: newToken,
    );
  }
}
