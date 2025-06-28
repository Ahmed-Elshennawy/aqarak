class UserProfile {
  final String uid;
  final String email;
  final String? fullName;
  final String? mobileNumber;

  const UserProfile({
    required this.uid,
    required this.email,
    this.fullName,
    this.mobileNumber,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'fullName': fullName,
    'mobileNumber': mobileNumber,
  };
}
