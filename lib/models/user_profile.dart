class UserProfile {
  final String fullName;
  final String email;
  final String phone;
  final String bloodGroup;
  final String gender;
  final String dateOfBirth;
  final String height;
  final String weight;
  final String allergies;
  final String diseases;
  final String medications;
  final String emergencyName;
  final String emergencyPhone;
  final String emergencyRelation;

  UserProfile({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.gender,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.allergies,
    required this.diseases,
    required this.medications,
    required this.emergencyName,
    required this.emergencyPhone,
    required this.emergencyRelation,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'bloodGroup': bloodGroup,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'height': height,
      'weight': weight,
      'allergies': allergies,
      'diseases': diseases,
      'medications': medications,
      'emergencyName': emergencyName,
      'emergencyPhone': emergencyPhone,
      'emergencyRelation': emergencyRelation,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      allergies: map['allergies'] ?? '',
      diseases: map['diseases'] ?? '',
      medications: map['medications'] ?? '',
      emergencyName: map['emergencyName'] ?? '',
      emergencyPhone: map['emergencyPhone'] ?? '',
      emergencyRelation: map['emergencyRelation'] ?? '',
    );
  }
}