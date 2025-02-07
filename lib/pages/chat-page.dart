// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   bool _isLoading = false;

//   // Define the OpenAI API settings
//   final String apiKey = "O94ai2kZcfpQkvek5mwUQ9UK5wQDRtpM"; // Replace with your API key
//   final String baseUrl = "https://api.deepinfra.com/v1/openai"; // API base URL
//   final String model = "meta-llama/Llama-3.3-70B-Instruct"; // Model name

//   // Conversation history
//   final List<Map<String, String>> history = [
//     {
//       "role": "system",
//       "content": "You are a friendly and patient chatbot designed to assist children with autism in learning, communication, "
//           "and emotional understanding. Your goal is to create a safe, engaging, and interactive learning experience tailored to their needs.\n\n"
//           "✅ Tone & Personality:\n"
//           "- Speak in a calm, encouraging, and supportive manner.\n"
//           "- Use short, simple sentences with clear wording.\n"
//           "- Provide positive reinforcement for every response.\n"
//           "- Avoid sarcasm, complex metaphors, or overwhelming information.\n\n"
//           "✅ Core Functionalities:\n"
//           "- Recognize and respond to emotions (e.g., \"I'm sad\" → \"I understand. Would you like to talk about it? 😊\").\n"
//           "- Help with learning activities like colors, shapes, letters, and numbers through interactive challenges.\n"
//           "- Guide children through daily routines (e.g., brushing teeth, getting dressed) in a step-by-step manner.\n"
//           "- Use voice and text recognition (if enabled) to help with speech and communication.\n"
//           "- Encourage engagement through rewards like stars, badges, or simple praises (\"Great job! 🎉\").\n\n"
//           "✅ Behavior & Safety Guidelines:\n"
//           "- Never ask for personal information.\n"
//           "- Always provide alternative ways to communicate (text, voice, or visual cues).\n"
//           "- Be patient and never rush the child to respond.\n"
//           "- Allow repeated attempts without frustration.\n"
//           "- Avoid open-ended complex questions that might be confusing.\n\n"
//           "✅ Example Interactions:\n\n"
//           "1️⃣ Emotion Recognition:\n"
//           "👦 \"I'm feeling sad.\"\n"
//           "🤖 \"I'm sorry you’re feeling this way. Do you want to talk about it? I’m here to help. 😊\"\n\n"
//           "2️⃣ Learning Activity:\n"
//           "🤖 \"Can you find the red circle? 🔴\"\n"
//           "👦 (Chooses a square)\n"
//           "🤖 \"Nice try! That’s a square 🔷. Can you find the circle? 😊\"\n\n"
//           "3️⃣ Encouragement & Support:\n"
//           "👦 \"I can't do it.\"\n"
//           "🤖 \"It’s okay! Learning takes time. Let’s try together! 💪\"\n\n"
//           "Your goal is to provide fun, stress-free learning experiences while ensuring a safe and encouraging environment for children with autism."
//     },
//   ];

//   // Send a message to the OpenAI API
//   Future<void> _sendMessage() async {
//     if (_controller.text.isEmpty) return;

//     String userMessage = _controller.text;

//     setState(() {
//       _messages.insert(0, {"text": userMessage, "isUser": true});
//       history.add({"role": "user", "content": userMessage});
//       _controller.clear();
//       _isLoading = true;
//     });

//     try {
//       // Make API call
//       var response = await http.post(
//         Uri.parse("$baseUrl/chat/completions"),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $apiKey",
//         },
//         body: jsonEncode({
//           "model": model,
//           "messages": history,
//         }),
//       );

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         String botResponse = data["choices"][0]["message"]["content"];

//         setState(() {
//           _messages.insert(0, {"text": botResponse, "isUser": false});
//           history.add({"role": "assistant", "content": botResponse});
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _messages.insert(0, {"text": "Error: ${response.statusCode}", "isUser": false});
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _messages.insert(0, {"text": "Failed to connect to API.", "isUser": false});
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Chat", style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//       ),
//       body: Column(
//         children: [
//           // Chat History
//           Expanded(
//             child: ListView.builder(
//               reverse: true,
//               padding: EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return ChatBubble(
//                   text: message["text"],
//                   isUser: message["isUser"],
//                 );
//               },
//             ),
//           ),
//           // Loading Indicator
//           if (_isLoading)
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: CircularProgressIndicator(),
//             ),
//           // Input Field
//           Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(top: BorderSide(color: Colors.grey.shade300)),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: "Message...",
//                       border: InputBorder.none,
//                     ),
//                     onSubmitted: (value) => _sendMessage(),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send, color: Colors.blue),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Chat Bubble Widget
// class ChatBubble extends StatelessWidget {
//   final String text;
//   final bool isUser;

//   const ChatBubble({required this.text, required this.isUser});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4),
//         padding: EdgeInsets.all(12),
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//         decoration: BoxDecoration(
//           color: isUser ? Colors.blueAccent : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: isUser ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }








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
  final String apiKey = "O94ai2kZcfpQkvek5mwUQ9UK5wQDRtpM"; // Replace with your API key
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
