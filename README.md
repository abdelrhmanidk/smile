# Smile — Educational App for Children with Autism

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white&style=flat-square"/>
  <img src="https://img.shields.io/badge/Firebase-Auth%20%26%20Firestore-FFCA28?logo=firebase&logoColor=black&style=flat-square"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=flat-square"/>
  <img src="https://img.shields.io/badge/Language-Arabic%20RTL-4CAF50?style=flat-square"/>
  <img src="https://img.shields.io/badge/AI-Llama%203.3%2070B-7B2FBE?style=flat-square"/>
</p>

**Smile** is an Arabic-first Flutter application designed to support children with autism in building foundational skills through interactive games, visual learning, and an AI-powered chat companion.

---

## Features

**Learning Modules** — Shapes, Colors, Emotions, and Animals, each with dedicated detail screens, animations, and audio feedback.

**Interactive Games** — A shape-matching quiz, an emotion drag-and-drop game with 3 progressive levels, and an Arabic letter spelling puzzle for animals.

**AI Chat Companion** — Powered by Llama 3.3 70B via DeepInfra, configured to communicate patiently with children using short sentences, positive reinforcement, and emotional awareness.

**Authentication** — Email/password with verification, Google Sign-In, and forgot-password support, backed by Firebase Auth and Firestore.

---

## Tech Stack

| Concern | Technology |
|---|---|
| Framework | Flutter 3.x + Dart |
| State & Routing | GetX |
| Backend | Firebase Auth, Cloud Firestore |
| AI | DeepInfra — `meta-llama/Llama-3.3-70B-Instruct` |
| Animations | Lottie, Hero transitions, AnimatedBuilder |
| Audio / Haptics | audioplayers, vibration |
| UI | Google Fonts (Poppins), flutter_svg, salomon_bottom_bar |

---

## Project Structure

```
lib/
├── main.dart / MyApp.dart          # Entry point, Firebase init, auth state
├── Routes/                         # GetX named routes & page definitions
├── models/                         # Data models (Animal, Emotion, Shape, Feeling…)
├── pages/                          # Core screens (Auth, Home, Chat, Profile, Search)
├── screens/                        # Feature screens (Shape, Color, Emotion, Animal, Games)
└── widgets/                        # Reusable components (painters, cards, dialogs…)
```

---

## Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- A configured Firebase project (Android & iOS)
- A DeepInfra API key

### Setup

```bash
# 1. Clone and install
git clone https://github.com/your-username/smile.git
cd smile
flutter pub get

# 2. Configure Firebase
flutterfire configure
# Enable: Email/Password auth, Google Sign-In, Cloud Firestore

# 3. Add your AI API key
# In lib/pages/chat-page.dart:
final String apiKey = "YOUR_DEEPINFRA_API_KEY";

# 4. Run
flutter run
```

---

## Roadmap

- [ ] Secure AI API key behind a backend proxy
- [ ] Persist game scores to Firestore
- [ ] Add a parent/teacher progress dashboard
- [ ] Expand content (numbers, Arabic letters)
- [ ] English localization
- [ ] Publish to Google Play & App Store

---

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit and push your changes
4. Open a Pull Request

---

## License

MIT License — see [LICENSE](LICENSE) for details.

---

<p align="center">Built to make learning accessible for every child.</p>
