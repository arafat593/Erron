import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/app_colors.dart';
import '../controllers/chat_controller.dart';

class ChatScreenView extends GetView<ChatController> {
  const ChatScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
                  controller.receiverImage != null &&
                      controller.receiverImage!.isNotEmpty
                  ? NetworkImage(controller.receiverImage!)
                  : null,
              child: controller.receiverImage == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 10),
            Text(controller.receiverName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.messages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(10),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isMe = msg.senderId != controller.receiverId;

                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blueAccent : Colors.grey[800],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft: Radius.circular(isMe ? 12 : 0),
                          bottomRight: Radius.circular(isMe ? 0 : 12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (msg.imageUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                controller.profile.user.value?.profileImage ??
                                    '',
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          if (msg.message != null)
                            Text(
                              msg.message!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          const SizedBox(height: 2),
                          /*Text(
                            "${msg.createdAt.hour}:${msg.createdAt.minute}",
                            style: TextStyle(color: Colors.white70, fontSize: 10),
                          ),*/
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.black26,
      child:TextFormField(
        controller: controller.messageController,
        decoration: InputDecoration(
          hintText: "Say Something...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon:  Icon(Icons.attach_file, color:AppColors.whiteLight),
                onPressed: () async {
                  final picker = ImagePicker();
                  final image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    controller.sendImage(image.path);
                  }
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.sentiment_satisfied_alt,
                  color: AppColors.whiteLight,
                ),
                onPressed: () {
                  // emoji action
                },
              ),

              IconButton(
                icon: const Icon(Icons.send, color: AppColors.whiteLight),
                onPressed: () {
                  controller.sendMessage();
                },
              ),
            ],
          ),

          fillColor: AppColors.outlineButtonColor,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),



    );
  }
}
