import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Active Users List
          Container(
            height: 110,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey[100],
            child: Obx(() {
              if (controller.isLoadingUsers.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.activeUsers.isEmpty) {
                return const Center(child: Text('No active users'));
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.activeUsers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final user = controller.activeUsers[index];
                  return GestureDetector(
                    onTap: () => controller.selectUser(user),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.profileImage),
                              onBackgroundImageError: (_, __) {
                                // Fallback icon or image
                              },
                              child: user.profileImage.isEmpty
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            Positioned(
                              right: 2,
                              bottom: 2,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.fullName.split(' ').first,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          Expanded(
            child: Obx(() {
              if (controller.selectedUser.value == null) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text('Select a user to start chatting'),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Chat Header for Selected User
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Text(
                          'Chatting with ${controller.selectedUser.value!.fullName}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  // Messages List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final msg = controller.messages[index];
                        return Align(
                          alignment: msg.isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: msg.isMe
                                  ? Colors.blue
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              msg.message,
                              style: TextStyle(
                                color: msg.isMe ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Input Area
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.messageController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.send, color: Colors.blue),
                          onPressed: controller.sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
    /*return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Message",
          style: AppTextStyles.bold24.copyWith(color: AppColors.whiteLight),
        ),
        actions: [
          SizedBox(
            width: 184,
            height: 34,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),

                border: Border.all(color: AppColors.whiteLight),
                color: Color(0x19F6F6FD),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Text(
                      "Search",
                      style: AppTextStyles.regular12.copyWith(
                        color: AppColors.whiteLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Obx(() {
              if (controller.activeUserInProgressing.value) {
                return const SizedBox(
                  height: 65,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.activeUserModel.isEmpty) {
                return const SizedBox(
                  height: 65,
                  child: Center(child: Text("No Active Users",style: TextStyle(color: AppColors.whiteLight),)),
                );
              }

              return SizedBox(
                height: 65,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.activeUserModel.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final data = controller.activeUserModel[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: GestureDetector(
                        onTap: ()async{
                          final token = await SharedPrefService.getUserToken();
                          if (token == null) {
                            Get.offAllNamed(Routes.LOGIN);
                            return;
                          }

                          Get.toNamed(Routes.CHAT_SCREEN,arguments: controller.activeUserModel[index]);
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: CircleAvatar(
                                backgroundImage: data.profileImage.isNotEmpty
                                    ? NetworkImage(data.profileImage)
                                    : const AssetImage(ImagePath.person)
                                as ImageProvider,
                              ),
                            ),
                            Positioned(
                              bottom: 9,
                              right: 6,
                              child: SizedBox(
                                height: 10,
                                width: 10,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),


          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            sliver: SliverList.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return buildPersonProfile();
              },
            ),
          ),
        ],
      ),
    );*/
  }

  /*Widget buildPersonProfile() {
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: (){
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: const CircleAvatar(),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cameron Williamson",
                              style: AppTextStyles.bold16.copyWith(
                                color: AppColors.whiteLight,
                              ),
                            ),
                            Text(
                              "Have you spoken to the delivery man? He is more than an hour late",
                              style: AppTextStyles.regular12.copyWith(

                                color: AppColors.whiteLight,overflow: TextOverflow.ellipsis,
                              ),maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "11.11",
                            style: AppTextStyles.regular12.copyWith(
                              color: AppColors.whiteLight,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.pinkColor,
                              ),
                              child: Center(child: Text("4",style: TextStyle(color: AppColors.whiteLight),)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }*/
}
