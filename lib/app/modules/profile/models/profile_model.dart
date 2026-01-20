import 'package:errone/app/modules/profile/models/kyc_model.dart';
import 'package:errone/app/modules/profile/models/past_stream_model.dart';

class ProfileModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final double coins;
  final bool isOnline;
  final int followingCount;
  final int followersCount;
  final int totalLikes;
  final bool isVerified;
  final String profileImage;
  final String coverImage;
  final String bio;
  final String gender;
  final String country;
  final String dateOfBirth;
  final double shady;
  final String authProvider;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  final String otp;
  final String accountStatus;
  final KycModel? kyc;
  final List<PastStreamModel> pastStreams;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.coins,
    required this.isOnline,
    required this.followingCount,
    required this.followersCount,
    required this.totalLikes,
    required this.isVerified,
    required this.profileImage,
    required this.coverImage,
    required this.bio,
    required this.gender,
    required this.country,
    required this.dateOfBirth,
    required this.shady,
    required this.authProvider,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.otp,
    required this.accountStatus,
    this.kyc,
    required this.pastStreams,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',

      coins: (json['coins'] as num?)?.toDouble() ?? 0.0,

      isOnline: json['is_online'] ?? false,
      followingCount: json['following_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      totalLikes: json['total_likes'] ?? 0,
      isVerified: json['is_verified'] ?? false,

      profileImage: json['profile_image'] ?? '',
      coverImage: json['cover_image'] ?? '',

      bio: json['bio'] ?? '',
      gender: json['gender'] ?? '',
      country: json['country'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',

      shady: (json['shady'] as num?)?.toDouble() ?? 0.0,

      authProvider: json['auth_provider'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      role: json['role'] ?? '',
      otp: json['otp'] ?? '',
      accountStatus: json['account_status'] ?? '',

      kyc: json['kyc'] != null ? KycModel.fromJson(json['kyc']) : null,

      pastStreams: (json['past_streams'] as List?)
          ?.map((e) => PastStreamModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'coins': coins,
      'is_online': isOnline,
      'following_count': followingCount,
      'followers_count': followersCount,
      'total_likes': totalLikes,
      'is_verified': isVerified,
      'profile_image': profileImage,
      'cover_image': coverImage,
      'bio': bio,
      'gender': gender,
      'country': country,
      'date_of_birth': dateOfBirth,
      'shady': shady,
      'auth_provider': authProvider,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'role': role,
      'otp': otp,
      'account_status': accountStatus,
      'kyc': kyc?.toJson(),
      'past_streams': pastStreams.map((e) => e.toJson()).toList(),
    };
  }
}






