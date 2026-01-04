
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../shared_pref_service/shared_pref_service.dart';

class SocketService extends GetxService {
  WebSocketChannel? _channel;

  final isConnected = false.obs;
  final incomingMessages = ''.obs;

  Future<void> connect() async {
    if (isConnected.value) return;

    final token = await SharedPrefService.getUserToken();
    if (token == null || token.isEmpty) {
      print("❌ No token, socket not connected");
      return;
    }

    try {
      final encodedToken = Uri.encodeComponent(token);
      final wsUrl = 'ws://eron.mtscorporate.com/api/v1/chat/ws?token=$encodedToken';
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      isConnected.value = true;
      print('✅ WebSocket Connected');

      _channel!.stream.listen(
            (message) {
          incomingMessages.value = message;
        },
        onDone: () {
          print('❌ WebSocket Closed');
          isConnected.value = false;
        },
        onError: (error) {
          print('⚠️ WebSocket Error: $error');
          isConnected.value = false;
        },
      );
    } catch (e) {
      print('❌ WebSocket Connection Failed: $e');
      isConnected.value = false;
    }
  }

  void disconnect() {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
      isConnected.value = false;
      print('🔌 WebSocket Disconnected');
    }
  }

  void sendMessage(String message) {
    if (_channel != null && isConnected.value) {
      _channel!.sink.add(message);
    }
  }
}







//from emon
/*
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService extends GetxController {

  WebSocketChannel? _channel;
  RxBool isConnected = false.obs;


  final incomingMessages = ''.obs;

  @override
  void onInit() {
    super.onInit();
    connect();
  }


  void connect() async {
    final token = GetStorage().read('token');
    if (token == null) return;

    try {
      final encodedToken = Uri.encodeComponent(token);
      final wsUrl = 'ws://eron.mtscorporate.com/api/v1/chat/ws?token=$encodedToken';

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      await _channel!.ready;

      isConnected.value = true;
      print('WebSocket Connected Successfully');

      _channel!.stream.listen(
            (message) {
          print('Received: $message');
          incomingMessages.value = message;
        },
        onDone: () {
          print('WebSocket Closed by Server');
          isConnected.value = false;

          Future.delayed(Duration(seconds: 3), () => connect());
        },
        onError: (error) {
          print('WebSocket Error: $error');
          isConnected.value = false;
        },
      );
    } catch (e) {
      print('Connection Failed: $e');
      isConnected.value = false;
    }
  }

  void sendMessage(String message) {
    if (_channel != null && isConnected.value) {
      _channel!.sink.add(message);
    } else {
      print('Cannot send message: WebSocket not connected');
    }
  }

  void close() {
    _channel?.sink.close();
    isConnected.value = false;
  }

  @override
  void onClose() {
    close();
    super.onClose();
  }
}*/

