import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scratch_project/app/modules/ChatDetailScreen/views/chat_detail_screen_view.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_client/web_socket_client.dart';

class ChatDetailScreenController extends GetxController {
     RxList<ChatMessage> messages = RxList<ChatMessage>([
    ]);

  final count = 0.obs;
  late WebSocket channel;
  @override
  void onInit() {
    connectWebSocket();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
    void connectWebSocket() {
      print("::: inside connect web socket");
     channel = WebSocket(
      Uri.parse('wss://meet-around-apis-production.up.railway.app/chat'),
    );

    channel.send('{"type": "init","userId": 7}');

    channel.messages.listen((message) {
      // webSocketResponse.value = message;
      print('::: WebSocket connection status: ${channel.connection.state}');
      messages.add(ChatMessage(text: message, isSent: false));
      print('::: WebSocket Response: $message');
      // print('::: WebSocket Connection Status: ${channel}');

    }, onError: (error) {
      print('::: WebSocket Error: $error');
      Get.snackbar('Error', 'WebSocket connection error: $error',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }, onDone: () {
      print('::: WebSocket connection closed');
      Get.snackbar('Info', 'WebSocket connection closed',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  void sendMessage(String content){
    channel.send('{"type": "message","senderId": 7,"receiverId": 8,"content": "Hello World"}');
  }


  void increment() => count.value++;
}
