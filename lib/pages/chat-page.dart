
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  // Define the OpenAI API settings
  final String apiKey = "--"; // Replace with your API key
  final String baseUrl = "https://api.deepinfra.com/v1/openai"; // API base URL
  final String model = "meta-llama/Llama-3.3-70B-Instruct"; // Model name

  // Conversation history
  final List<Map<String, String>> history = [
    {
      "role": "system",
      "content": "You are a friendly and patient chatbot designed to assist children with autism in learning, communication, and emotional understanding..."
    },
  ];

  // Typing animation dots
  int _typingDotCount = 1;
  Timer? _typingTimer;

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  // Start typing animation
  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _typingDotCount = (_typingDotCount % 3) + 1; // Cycle between 1 to 3 dots
      });
    });
  }

  // Stop typing animation
  void _stopTypingAnimation() {
    _typingTimer?.cancel();
    _typingDotCount = 1; // Reset dots
  }

  // Send a message to the OpenAI API
  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMessage = _controller.text;

    setState(() {
      _messages.insert(0, {"text": userMessage, "isUser": true});
      history.add({"role": "user", "content": userMessage});
      _controller.clear();
      _isTyping = true; // Show typing animation
      _startTypingAnimation();
    });

    try {
      // Make API call
      var response = await http.post(
        Uri.parse("$baseUrl/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": model,
          "messages": history,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String botResponse = data["choices"][0]["message"]["content"];

        setState(() {
          _messages.insert(0, {"text": botResponse, "isUser": false});
          history.add({"role": "assistant", "content": botResponse});
          _isTyping = false;
          _stopTypingAnimation();
        });
      } else {
        setState(() {
          _messages.insert(0, {"text": "Error: ${response.statusCode}", "isUser": false});
          _isTyping = false;
          _stopTypingAnimation();
        });
      }
    } catch (e) {
      setState(() {
        _messages.insert(0, {"text": "Failed to connect to API.", "isUser": false});
        _isTyping = false;
        _stopTypingAnimation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          // Chat History
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                // Show "Typing..." bubble
                if (_isTyping && index == 0) {
                  return TypingBubble(dotCount: _typingDotCount);
                }

                final message = _messages[_isTyping ? index - 1 : index];
                return ChatBubble(
                  text: message["text"],
                  isUser: message["isUser"],
                );
              },
            ),
          ),
          // Input Field
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Message...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
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

// Chat Bubble Widget
class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

// Typing Bubble Widget
class TypingBubble extends StatelessWidget {
  final int dotCount;

  const TypingBubble({required this.dotCount});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            dotCount,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
