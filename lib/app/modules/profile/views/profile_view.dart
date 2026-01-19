
import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050511), // Main background
      body: SingleChildScrollView(
     physics: ClampingScrollPhysics(),
        child: Stack(
          children: [
            // 1. Fixed Banner Image at the top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 270, // Height of the banner
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=2029&auto=format&fit=crop',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // 2. Scrollable Content
            Column(
              children: [
                const SizedBox(
                  height: 230,
                ), // Transparent spacing to show banner
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    // The "Sheet" Container with Rounded Corners
                    Container(
                      padding: const EdgeInsets.only(top: 60, bottom: 40),
                      decoration: const BoxDecoration(
                        color: Color(0xFF050511),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildProfileInfo(),
                          const SizedBox(height: 24),
                          _buildStats(),
                          const SizedBox(height: 24),
                          _buildTrustScore(),
                          const SizedBox(height: 24),
                          _buildActionButtons(controller),
                          const SizedBox(height: 24),
                          _buildTabs(controller),
                          const SizedBox(height: 24),
                          _buildTabContent(controller),
                        ],
                      ),
                    ),

                    // The Avatar overlapping the border
                    Positioned(
                      top: -50,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.pinkAccent,
                                width: 2,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Free',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(ProfileController controller) {
    return Obx(() {
      switch (controller.selectedTabIndex.value) {
        case 0:
          return _buildPersonalInfo();
        case 1:
          return _buildPastStreams();
        case 2:
          return _buildInsights();
        default:
          return _buildPersonalInfo();
      }
    });
  }

  Widget _buildProfileInfo() {
    return Obx(() {
      if(controller.isLoading.value){
        return Center(child:  CircularProgressIndicator(),);
      }
      return Column(
      children: [
        Text(
          controller.user.value?.fullName ?? "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            controller.user.value?.fullName ?? "No Bio",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ),
        ElevatedButton(onPressed: ()async{
       await   SharedPrefService.clear();
       Get.offAllNamed(Routes.LOGIN);
        }, child: Text("Logout"),)
      ]);
    },
    );
  }

  Widget _buildStats() {
    return Obx((){
      if(controller.isLoading.value){
        return Center(child: CircularProgressIndicator(),);
      }
      final user = controller.user.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          _buildStatItem("${user?.followersCount ?? 0}", 'Followers'),
          _buildStatItem('${user?.followingCount ?? 0}', 'Following'),
          _buildStatItem('${user?.totalLike ?? 0}', 'Likes'),
        ],
      );
    });
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
      ],
    );
  }

  Widget _buildTrustScore() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Trust Score',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '92%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.pinkAccent],
                    stops: [0.92, 0.92],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '92 Legit',
                style: TextStyle(color: Colors.grey[400], fontSize: 10),
              ),
              const Text(
                '8% Suspicious',
                style: TextStyle(color: Colors.redAccent, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ProfileController controller) {
    return Obx(() {
      final isGoLiveSelected = controller.selectedActionIndex.value == 0;
      final isEditProfileSelected = controller.selectedActionIndex.value == 1;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Go Live Button
          isGoLiveSelected
              ? ElevatedButton(
            onPressed: () => controller.selectedActionIndex.value = 0,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D4BFB),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Go Live',
              style: TextStyle(color: Colors.white),
            ),
          )
              : OutlinedButton(
            onPressed: () => controller.selectedActionIndex.value = 0,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1E2C),
              side: BorderSide(color: Colors.grey.withOpacity(0.2)),
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Go Live',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          // Edit Profile Button
          isEditProfileSelected
              ? ElevatedButton(
            onPressed: () => controller.selectedActionIndex.value = 1,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D4BFB),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white),
            ),
          )
              : OutlinedButton(
            onPressed: () => controller.selectedActionIndex.value = 1,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1E2C),
              side: BorderSide(color: Colors.grey.withOpacity(0.2)),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTabs(ProfileController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(
            () => Row(
          children: [
            _buildTabButton('All', 0, controller),
            const SizedBox(width: 8),
            _buildTabButton('Past Streams', 1, controller),
            const SizedBox(width: 8),
            _buildTabButton('Insights', 2, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index, ProfileController controller) {
    bool isSelected = controller.selectedTabIndex.value == index;
    return GestureDetector(
      onTap: () {
        controller.selectedTabIndex.value = index;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3D4BFB) : const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? null
              : Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(() {
        if(controller.isLoading.value){
          return Center(child: CircularProgressIndicator(),);
        }
        final user= controller.user.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Personal Info',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.edit, color: Colors.grey, size: 20),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(user?.gender ?? ""),
            _buildInfoRow(user?.bio ?? ""),
            _buildInfoRow(user?.country ?? ""),
            _buildInfoRow(user?.email ?? ""),
            _buildInfoRow(user?.dateOfBirth ?? ""),
          ],
        );
      })
    );
  }

  Widget _buildPastStreams() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(Icons.video_library, color: Colors.grey[700], size: 48),
            const SizedBox(height: 16),
            Text('No past streams', style: TextStyle(color: Colors.grey[400])),
          ],
        ),
      ),
    );
  }

  Widget _buildInsights() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Wallet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildWalletCard(),
          const SizedBox(height: 24),
          const Text(
            'Buy Tokens',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTokenGrid(),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3D4BFB), Color(0xFFE91E63)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Available Balance',
            style: AppTextStyles.bold16,
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
               Text(
                '10250',
                style: AppTextStyles.bold26
              ),
              const SizedBox(width: 4),
              const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'Tokens',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.white24,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
               Text(
                '\$550.00',
                style: AppTextStyles.bold26
              ),
              const SizedBox(width: 4),
              const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'Tokens',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF3D4BFB),
                        Color(0xFFE91E63),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      // TODO: History action
                    },
                    child: const Center(
                      child: Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3D4BFB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Withdraw'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTokenGrid() {
    final tokens = [
      {'amount': '100', 'price': '\$0.99'},
      {'amount': '500', 'price': '\$4.99'},
      {'amount': '1200', 'price': '\$9.99'},
      {'amount': '6500', 'price': '\$49.99'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: tokens.length,
      itemBuilder: (context, index) {
        return _buildTokenCard(
          tokens[index]['amount']!,
          tokens[index]['price']!,
        );
      },
    );
  }
}
Widget _buildTokenCard(String amount, String price) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    decoration: BoxDecoration(
      color: const Color(0xFF161621),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.05)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber.withOpacity(0.3)),
          ),
          child: const Icon(Icons.wallet, color: Colors.amber, size: 24),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Tokens',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D4BFB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Text(
              '$price Pay',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildInfoRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }


