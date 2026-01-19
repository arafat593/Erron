
class StreamModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final double coins;
  final bool isVerified;
  final String? phoneNumber;
  final String? country;
  final String? gender;
  final String? dateOfBirth;
  final String? bio;
  final double? shady ;
  final bool isOnline;
  final List<dynamic> following;
  final int followingCount;
  final int followersCount;
  final int totalLikes;
  final String accountStatus;
  final String otp;
  final String role;
  final String profileImage;
  final String authProvider;
  final String createdAt;
  final String updatedAt;

  StreamModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.coins,
    required this.isVerified,
    this.phoneNumber,
    this.country,
    this.gender,
    this.dateOfBirth,
    this.bio,
    required this.isOnline,
    required this.following,
    required this.followingCount,
    required this.followersCount,
    required this.totalLikes,
    required this.accountStatus,
    required this.otp,
    required this.role,
    required this.profileImage,
    required this.authProvider,
    required this.createdAt,
    required this.updatedAt, this.shady,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) => StreamModel(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    coins: json['coins'],
    isVerified: json['is_verified'],
    phoneNumber: json['phone_number'],
    country: json['country'],
    gender: json['gender'],
    dateOfBirth: json['date_of_birth'],
    bio: json['bio'],
    isOnline: json['is_online'],
    shady: json['shady'],
    following: json['following'] ?? [],
    followingCount: json['following_count'],
    followersCount: json['followers_count'],
    totalLikes: json['total_likes'],
    accountStatus: json['account_status'],
    otp: json['otp'],
    role: json['role'],
    profileImage: json['profile_image'],
    authProvider: json['auth_provider'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}

class AllStreamModel {
  final String id;
  final StreamModel host;
  final String channelName;
  final String title;
  final String category;
  final String thumbnail;
  final String livekitToken;
  final bool isPremium;
  final double entryFee;
  final String? startTime;
  final String? endTime;
  final int totalLikes;
  final int earnCoins;
  final int totalViews;
  final int totalComments;
  final String status;
  final String createdAt;
  final String updatedAt;

  AllStreamModel({
    required this.id,
    required this.host,
    required this.channelName,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.livekitToken,
    required this.isPremium,
    required this.entryFee,
    this.startTime,
    this.endTime,
    required this.totalLikes,
    required this.earnCoins,
    required this.totalViews,
    required this.totalComments,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllStreamModel.fromJson(Map<String, dynamic> json) => AllStreamModel(
    id: json['_id'],
    host: StreamModel.fromJson(json['host']),
    channelName: json['channel_name'],
    title: json['title'],
    category: json['category'],
    thumbnail: json['thumbnail'],
    livekitToken: json['livekit_token'],
    isPremium: json['is_premium'],
    entryFee: json['entry_fee'],
    startTime: json['start_time'],
    endTime: json['end_time'],
    totalLikes: json['total_likes'],
    earnCoins: json['earn_coins'],
    totalViews: json['total_views'],
    totalComments: json['total_comments'],
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'host': host.toJson(),
    'channel_name': channelName,
    'title': title,
    'category': category,
    'thumbnail': thumbnail,
    'livekit_token': livekitToken,
    'is_premium': isPremium,
    'entry_fee': entryFee,
    'start_time': startTime,
    'end_time': endTime,
    'total_likes': totalLikes,
    'earn_coins': earnCoins,
    'total_views': totalViews,
    'total_comments': totalComments,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

extension HostExtension on StreamModel {
  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'coins': coins,
    'is_verified': isVerified,
    'phone_number': phoneNumber,
    'country': country,
    'gender': gender,
    'date_of_birth': dateOfBirth,
    'bio': bio,
    'is_online': isOnline,
    'following': following,
    'following_count': followingCount,
    'followers_count': followersCount,
    'total_likes': totalLikes,
    'account_status': accountStatus,
    'otp': otp,
    'role': role,
    'profile_image': profileImage,
    'auth_provider': authProvider,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
