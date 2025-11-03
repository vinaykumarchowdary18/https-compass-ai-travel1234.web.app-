# 🌍 Compass AI Travel Planning

A modern, AI-powered travel planning application that helps you discover and plan your perfect trip. Built with Flutter and Firebase for a beautiful, cross-platform experience.

🌐 **Live Demo:** [compass-ai-travel1234.web.app](https://compass-ai-travel1234.web.app)

[![Try in IDX](https://cdn.idx.dev/btn/try_light_32.svg)](https://idx.google.com/new?template=https%3A%2F%2Fgithub.com%2FFirebaseExtended%2Fcompass-ai-travel-planning-sample-flutter)

## ✨ Features

- 🗺️ Discover destinations worldwide
- 🤖 AI-powered trip recommendations using Firebase Data Connect
- 📅 Itinerary planning and management
- 🔍 Search and filter destinations
- 📱 Responsive design for all devices
- 🔄 Real-time data synchronization with Firestore

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (latest stable version)
- Firebase project with Data Connect enabled
- Google Cloud account with billing enabled

### Running in Project IDX (Recommended)

1. Click the "Try in IDX" button above to launch the project in Google's Project IDX
2. Set up your Gemini API key in the IDX environment
3. Connect to the Firebase Data Connect emulator
4. Start the genkit server
5. Open the web preview to see the app in action

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/FirebaseExtended/compass-ai-travel-planning-sample-flutter.git
   cd compass-ai-travel-planning-sample-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Firebase Data Connect for your project
   - Configure your Firebase configuration in `lib/config.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Backend**: Firebase (Authentication, Firestore, Data Connect)
- **AI Integration**: Gemini API
- **State Management**: Provider/Riverpod
- **Maps**: Google Maps API
- **Deployment**: Firebase Hosting

## 📂 Project Structure

```
lib/
├── main.dart          # App entry point
├── config/            # Configuration files
├── models/            # Data models
├── screens/           # App screens
├── services/          # Business logic and API services
├── utils/             # Helper functions
└── widgets/           # Reusable UI components
```

## 📚 Learn More

- [How Firebase Genkit Helped Add AI to Our Compass App](https://developers.googleblog.com/en/how-firebase-genkit-helped-add-ai-to-our-compass-app/)
- [Build an AI-Powered Travel App with Firebase](https://firebase.google.com/codelabs/ai-genkit-rag)
- [Firebase Data Connect Documentation](https://firebase.google.com/docs/data-connect)

## 🔒 Guardrails API Integration

To enable AI safety features:

1. Follow the [Guardrails API](https://developers.google.com/checks/guide/ai-safety/guardrails) setup guide
2. Authorize your application:
   ```bash
   gcloud auth application-default login --scopes=https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/checks
   ```
3. Restart the genkit server

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## 📝 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 📬 Contact

For questions or feedback, please open an issue on the [GitHub repository](https://github.com/FirebaseExtended/compass-ai-travel-planning-sample-flutter).

---

> **Note**: This app is not an officially supported Google product.
