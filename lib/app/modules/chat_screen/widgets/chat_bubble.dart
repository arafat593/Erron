// import 'package:flutter/material.dart';
//
// import '../models/chat_model.dart';
//
// class ChatBubble extends StatelessWidget {
//   final ChatMessage message;
//
//   const ChatBubble({super.key, required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//       child: Row(
//         mainAxisAlignment:
//         message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           /// Opponent Profile Image
//           if (!message.isMe)
//             const CircleAvatar(
//               radius: 18,
//               backgroundImage: AssetImage("assets/profile.png"),
//             ),
//
//           const SizedBox(width: 8),
//
//           /// Message Bubble
//           Container(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * .65,
//             ),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: message.isMe
//                   ? Colors.blueAccent
//                   : Colors.grey.shade200,
//               borderRadius: BorderRadius.only(
//                 topLeft: const Radius.circular(16),
//                 topRight: const Radius.circular(16),
//                 bottomLeft:
//                 message.isMe ? const Radius.circular(16) : Radius.zero,
//                 bottomRight:
//                 message.isMe ? Radius.zero : const Radius.circular(16),
//               ),
//             ),
//             child: Text(
//               message.message,
//               style: TextStyle(
//                 color: message.isMe ? Colors.white : Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
