# weather_app

A Flutter application for displaying weather information based on location.

## Getting Started

## Overview

The Weather App is a mobile application developed using Flutter that allows users to view weather information based on their location. The app utilizes various APIs and libraries to retrieve weather data and provide an intuitive user interface for displaying the information.

Key features of the Weather App include:

- Location-based weather information: The app can fetch weather data based on the user's current location or a manually entered location.

- Automatic location detection: If the user does not provide a location, the app can use the device's GPS capabilities to determine the current location.

- Persistent storage: The app uses the `shared_preferences` package to store and retrieve the user's preferred location, allowing for quick access to weather information upon subsequent app launches.

- State management: The `provider` package is used for efficient state management and dependency injection, ensuring a smooth user experience and easy integration of new features.

- Network requests: The app employs the `http` package to make HTTP requests to weather APIs and fetch real-time weather data.

- Geolocation services: The `geolocator` package is used to access the device's geolocation services, enabling the app to determine latitude and longitude coordinates for fetching weather data.

- Internationalization support: The app integrates the `intl` package for internationalization and localization support, allowing for the display of weather information in different languages and date/time formats.

## Setup

To set up and run the project, follow these steps:

1. Make sure you have Flutter installed. If not, refer to the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

2. Clone this repository to your local machine.

3. Open the project in your preferred IDE.

4. Install the project dependencies by running the following command in the project directory:

   flutter pub get
  

5. Ensure you have a device (emulator or physical device) connected to your development machine.

6. Run the application using the following command:

  
   flutter run

   This will build and run the app on the connected device.

## Dependencies

The following dependencies are used in this project:

- shared_preferences: ^2.2.0
  Used for saving and retrieving location information.

- provider: ^6.0.5
  Used for state management and dependency injection.

- google_fonts: ^5.1.0
  Used for custom font styling.

- http: ^1.1.0
  Used for making HTTP requests to fetch weather data.

- geolocator: ^9.0.2
  Used for retrieving device location.

- intl: ^0.18.1
  Used for internationalization support.

Note: Make sure to check the `pubspec.yaml` file for the exact versions of the dependencies.
