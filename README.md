

# Agora Call Application

A new Flutter project for audio and video calling functionality.

## Getting Started

This project is a starting point for a Flutter application that uses Agora for audio and video calls, Firestore for user information and call status, and an audio player for playing ringtones.


### Flutter Version

This project uses **Flutter version 3.24.3**.

### Installation

1. **Clone the repository:**
    ```sh
    git clone <repository-url>
    cd agora_call
    ```

2. **Install dependencies:**
    ```sh
    flutter pub get
    ```

3. **Set up Firebase:**
    - Follow the instructions to set up Firebase for your Flutter project: [Firebase Setup](https://firebase.flutter.dev/docs/overview)
    - Add your `google-services.json` for Android and `GoogleService-Info.plist` for iOS to the respective directories.

4. **Run the application:**
    ```sh
    flutter run
    ```

### Usage

1. **Launch the app on two devices.**
2. **On the first device, select "I am Caller".**
3. **On the second device, select "I am Receiver".**
4. **The call logic will be executed based on the selection.**

### Features

- **Audio and Video Calls:** Using Agora SDK for real-time communication.
- **Agora RTC Token Generation:** Using for secure call sessions.

- **Ringtone:** Using `audioplayers` package to play ringtones.
- **User Information and Call Status:** Using Firestore to manage user data and call status.
- **Real-time Call UI:** Displaying call status and user interface in real-time.
- **Device Connection Status:** Checking device connection status if it is connected to network or not.

### Dependencies

- **Flutter SDK**
- **Cupertino Icons:** ^1.0.8
- **Flutter Bloc:** ^9.0.0
- **Agora RTC Engine:** ^6.3.2
- **Permission Handler:** ^11.3.1
- **Firebase Core:** ^3.10.1
- **Firebase Storage:** ^12.4.1
- **Cloud Firestore:** ^5.6.2
- **Audioplayers:** ^6.1.1
- **Fluttertoast:** ^8.2.12
- **Agora UIKit:** [GitHub Repository](https://github.com/mohamedibrahim33/VideoUIKit-Flutter-min-SDK-21)
- **Agora RTM:** ^1.5.9
- **Connectivity Wrapper:** ^2.0.0 - To check if the device is connected to a network.

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
### Demo Video

Watch the demo video of the app in action: [Demo Video](https://drive.google.com/file/d/your-demo-video-link/view)






