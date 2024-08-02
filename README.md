<div align="center">
  <img src="Screenshots/MyWaterLogo.png" width="30%" />
  <br><br>
  
  [![Language](https://img.shields.io/badge/Language-Swift-fa7343.svg?style=flat)](https://developer.apple.com/swift/)
  [![Xcode](https://img.shields.io/badge/Xcode-16-1575f9.svg?style=flat)](https://developer.apple.com/xcode/)
  [![Platform](https://img.shields.io/badge/Platform-iOS%2015%2B-blue.svg?style=flat)](https://www.apple.com/by/ios/ios-15/)<br>
  [![Platform](https://img.shields.io/badge/Category-Health%2B-darkGreen.svg?style=flat)](https://apps.apple.com/us/charts/iphone/health-fitness-apps/6013)
  [![License](https://img.shields.io/badge/License-Apache%202.0-800080.svg)](https://www.apache.org/licenses/LICENSE-2.0) <br>
</div>

# MyWater

<div style="text-align: justify;">
MyWater is your ultimate companion for tracking daily water intake. Set personalized daily goals by choosing your desired volume and the number of glasses per day. Monitor your progress with a calendar view and analyze your water consumption by day, week, month, or year. Receive daily reminders to stay hydrated and achieve your goals. Drink water, stay healthy, and reach your hydration goals with MyWater!
</div>

## App Demo <br>

<div align="center">
  <a href="https://youtu.be/XWWipomukE4">
    <br> <img src="Screenshots/MyWaterYT.png" alt="App Demo" width="600" />
  </a>
  
  [YouTube link to App Demo](https://youtu.be/XWWipomukE4)
</div>

## Key Features <br>

- **Secure Authentication:** Authentication is managed using the Firebase service.
- **Daily Water Consumption Goals:** Set and track your daily water intake goals.
- **Daily Reminders:** Sign up for notifications to help you meet your hydration targets.
- **Consumption History:** View your water consumption history and track your progress with the calendar feature.

## Technologies Used in MyWater <br>

1. Programming Language: [Swift](https://developer.apple.com/swift/) ([UIKit](https://developer.apple.com/documentation/uikit))
2. Authentication Solution: [FirebaseAuth](https://firebase.google.com/docs/auth)
   - Verification: [Email](https://firebase.blog/posts/2017/02/email-verification-in-firebase-auth)
4. Data Storage: [Firestore](https://firebase.google.com/docs/firestore)
5. Layout Purposes Helper: [SnapKit](https://github.com/SnapKit/SnapKit)
6. Custom Tab Bar Dependencies:
   - [RxGesture](https://github.com/RxSwiftCommunity/RxGesture) for handling tapping on Tab Bar items
   - [RxSwift](https://github.com/ReactiveX/RxSwift) for informing the TabBarController that item has been tapped
7. Custom View Forms: [UIBezierPath](https://developer.apple.com/documentation/uikit/uibezierpath)
8. Library for displaying messages to the user about the status of settings: [Toast-Swift](https://github.com/scalessec/Toast-Swift)

## Start App <br>

To run this project on your local machine, follow these steps:
1. Create a [Firebase](https://firebase.google.com) Project:
   - Register on Firebase and create a new project.
   - Select the iOS platform and fill in the required details.
   - Download the GoogleService-Info.plist file.
   - Follow the instructions on the Firebase website to complete ios project setup.
2. Add the Configuration File:
   - Place the GoogleService-Info.plist file in the MyWater folder of your project.
3. Set Up Firebase Services:
   - Enable Authentication and select the Email/Password provider.
   - Enable Firestore Database:
     - Set the name and location.
     - Secure rules: Start in test mode.

## Screenshots <br>

<p align="center">
  <img src="Screenshots/SignUpSCR.png" width="280" />
  <img src="Screenshots/SignInSCR.png" width="280" />
  <img src="Screenshots/ResetSCR.png" width="280" />
  <img src="Screenshots/CalendarSCR.png" width="280" />
  <img src="Screenshots/MyWaterSCR2.png" width="280" />
  <img src="Screenshots/MyWaterSCR1.png" width="280" />
  <img src="Screenshots/SettingsSCR1.png" width="280" />
  <img src="Screenshots/SettingsSCR2.png" width="280" />
  <img src="Screenshots/DailyReminder.png" width="280" />
</p>
