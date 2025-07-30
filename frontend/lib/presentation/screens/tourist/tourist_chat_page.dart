import 'package:flutter/material.dart';
import 'package:frontend/data/models/chat_message_model.dart';
import 'package:frontend/data/services/chat_service.dart';

class TouristChatPage extends StatefulWidget {
  final String guideId;
  final String guideName;

  const TouristChatPage({
    Key? key,
    required this.guideId,
    required this.guideName,
  }) : super(key: key);

  @override
  State<TouristChatPage> createState() => _TouristChatPageState();
}

class _TouristChatPageState extends State<TouristChatPage> {
  List<ChatMessage> messages = [];
  final TextEditingController controller = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChat();
  }

  Future<void> _loadChat() async {
    try {
      final data = await ChatService.getChat(widget.guideId);
      setState(() {
        messages = data;
        isLoading = false;
      });
    } catch (e) {
      print("❌ Chat load failed: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    controller.clear();

    final success = await ChatService.sendMessage(
      receiverId: widget.guideId,
      message: text,
    );

    if (success) {
      _loadChat(); // reload to see new message
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to send message')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with ${widget.guideName}"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[messages.length - 1 - index];
                      final isMe = msg.senderId != widget.guideId;

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.green.shade200
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(msg.message),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(hintText: 'Type your message...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
