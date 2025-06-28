import 'package:hive/hive.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 2)
class ProfileModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final double balance;

  @HiveField(3)
  final String password; // 🔐 Added password

  ProfileModel({
    required this.name,
    required this.email,
    required this.balance,
    required this.password,
  });

  ProfileModel copyWith({String? name, String? email, double? balance, String? password}) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      password: password ?? this.password,
    );
  }
}
