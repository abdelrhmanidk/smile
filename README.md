# Smile — AI-Assisted Learning for Children with Autism

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white&style=flat-square"/>
  <img src="https://img.shields.io/badge/Firebase-Auth%20%26%20Firestore-FFCA28?logo=firebase&logoColor=black&style=flat-square"/>
  <img src="https://img.shields.io/badge/Language-Arabic%20RTL-4CAF50?style=flat-square"/>
  <img src="https://img.shields.io/badge/AI-Llama%203.3%2070B-7B2FBE?style=flat-square"/>
</p>

> **1st Place in Egypt — Benha University AI Hackathon**

**Smile** is an Arabic-first Flutter application designed to help children on the autism spectrum build foundational skills through visual learning, interactive games, and an AI-powered chat companion.

The project was developed by a student team led by [Abdelrahman Elsharkawi](https://github.com/abdelrhmanidk).

## What it does

- **Learning modules:** Shapes, colors, emotions, and animals with animations and audio feedback.
- **Interactive games:** Shape matching, progressive emotion exercises, and Arabic-letter spelling puzzles.
- **AI chat companion:** Llama 3.3 70B through DeepInfra, prompted to use short sentences, patient language, positive reinforcement, and emotional awareness.
- **Authentication and persistence:** Email/password, Google Sign-In, Firebase Auth, and Cloud Firestore.

## Engineering highlights

| Area | Implementation |
|---|---|
| Application | Flutter 3.x and Dart |
| State and routing | GetX |
| Backend services | Firebase Auth and Cloud Firestore |
| LLM integration | DeepInfra — `meta-llama/Llama-3.3-70B-Instruct` |
| Interaction design | Lottie, audio, haptics, drag-and-drop, and custom painters |
| Accessibility direction | Arabic-first RTL interface with short, supportive interactions |

## Project structure

```text
lib/
├── main.dart / MyApp.dart          # Firebase initialization and auth state
├── Routes/                         # GetX routes
├── models/                         # Learning and game data models
├── pages/                          # Auth, home, chat, profile, and search
├── screens/                        # Learning modules and interactive games
└── widgets/                        # Reusable UI and interaction components
```

## Run locally

### Prerequisites

- Flutter SDK 3.x
- A configured Firebase project
- A DeepInfra API key

```bash
git clone https://github.com/abdelrhmanidk/smile.git
cd smile
flutter pub get
flutterfire configure
flutter run
```

For local prototyping, configure the model provider in `lib/pages/chat-page.dart`.

> **Security note:** Do not ship an LLM provider key inside the client application. A production deployment should send model requests through an authenticated backend proxy with rate limiting and secret management.

## Roadmap

- [ ] Move LLM inference behind a secure backend
- [ ] Persist learning progress and game scores
- [ ] Add a parent and teacher analytics dashboard
- [ ] Expand Arabic learning content
- [ ] Add English localization
- [ ] Publish production mobile builds

## License

MIT — see [LICENSE](LICENSE).
