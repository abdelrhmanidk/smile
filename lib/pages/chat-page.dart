import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  String azureEndpoint =
      "https://eduapp2040737533.services.ai.azure.com/models";
  String apiKey =
      "34XeDfUXteS0mcLyh0mTTeefh10TX0XQD41WESdKB444UCft3sW8JQQJ99BBACYeBjFXJ3w3AAAAACOG71wj"; // Replace with your actual Azure API key
  String deploymentName = "gpt-4o"; // Your OpenAI deployment name
  String apiVersion = "2023-12-01-preview"; // Your Azure API version

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMessage = _controller.text;

    setState(() {
      _messages.insert(0, {"text": userMessage, "isUser": true});
      _controller.clear();
      _isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse(
            "$azureEndpoint/openai/deployments/$deploymentName/chat/completions?api-version=$apiVersion"),
        headers: {
          "Content-Type": "application/json",
          "api-key": apiKey,
        },
        body: jsonEncode({
          "messages": [
            {"role": "system", "content": "You are a helpful AI assistant."},
            {"role": "user", "content": userMessage}
          ],
          "max_tokens": 100,
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String botResponse = data["choices"][0]["message"]["content"];

        setState(() {
          _messages.insert(0, {"text": botResponse, "isUser": false});
          _isLoading = false;
        });
      } else {
        setState(() {
          _messages.insert(
              0, {"text": "Error: ${response.statusCode}", "isUser": false});
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _messages
            .insert(0, {"text": "Failed to connect to API.", "isUser": false});
        _isLoading = false;
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        children: [
          // Chat History
          Expanded(
            child: ListView.builder(
              reverse: true, // Show latest messages at the bottom
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  text: message["text"],
                  isUser: message["isUser"],
                );
              },
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(),
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
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
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
