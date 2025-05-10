# Weather Web App

A responsive Flutter Web Application for displaying real-time weather information using the OpenWeather API.

![Weather App](https://placehold.co/600x400?text=Weather+App)

## 🌦 Overview

This application provides real-time weather updates including current conditions, hourly forecasts, and an 8-day outlook. It features responsive layouts optimized for mobile, tablet, and desktop viewing experiences. The app uses geolocation to automatically display weather for the user's current location, with a modern UI that adapts to different screen sizes.

## 🛠 Technologies

- **Flutter 3.6+**: UI framework
- **Dart 3.6+**: Programming language
- **Bloc/Cubit**: State management
- **Get_It**: Dependency injection
- **Firebase**: Analytics and remote config
- **OpenWeather API**: Weather data provider
- **Nominatim API**: Reverse geocoding
- **Geolocator**: Device location services

## 🏗 Architecture

The project follows a clean architecture approach:

- **Core**: Base configurations, utilities, and shared components
- **Features**: Domain-driven feature modules
  - Authentication: Login/user management
  - Weather: Weather data fetching and display
- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and entities
- **Data Layer**: Data sources and repositories

## ⚙️ Setup & Configuration

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- Dart SDK (3.6.0 or higher) 
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)
- Git

### Environment Variables

The app requires the following environment variables:

```
WEATHER_BASE_URL=https://api.openweathermap.org/data/3.0/onecall
WEATHER_API_KEY=your_openweather_api_key
REVERSE_BASE_URL=https://nominatim.openstreetmap.org/reverse
```

### Getting Started

1. **Clone the repository**

```bash
git clone https://your-repository-url.git
cd flutter_web_app
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Set up environment variables**

There are two ways to provide the required environment variables:

a) Using launch configurations in VS Code (recommended for development):
   - The `.vscode/launch.json` file already contains the required configuration
   - You can update the API key if needed

b) Command line:
```bash
flutter run --dart-define=WEATHER_BASE_URL=https://api.openweathermap.org/data/3.0/onecall --dart-define=WEATHER_API_KEY=your_api_key --dart-define=REVERSE_BASE_URL=https://nominatim.openstreetmap.org/reverse
```

4. **Run the app**

```bash
flutter run -d chrome
```

### Building for Production

```bash
flutter build web --dart-define=WEATHER_BASE_URL=https://api.openweathermap.org/data/3.0/onecall --dart-define=WEATHER_API_KEY=your_api_key --dart-define=REVERSE_BASE_URL=https://nominatim.openstreetmap.org/reverse
```

## 🔑 API References

### OpenWeather API

The app uses the OpenWeather One Call API 3.0 to fetch comprehensive weather data:

- **Base URL**: `https://api.openweathermap.org/data/3.0/onecall`
- **Documentation**: [OpenWeather One Call API](https://openweathermap.org/api/one-call-3)
- **Required Parameters**:
  - `lat`: Latitude coordinate
  - `lon`: Longitude coordinate
  - `appid`: Your API key
  - `units`: Metric (for Celsius temperatures)

### Nominatim API

The app uses the Nominatim API for reverse geocoding (converting coordinates to address):

- **Base URL**: `https://nominatim.openstreetmap.org/reverse`
- **Documentation**: [Nominatim API](https://nominatim.org/release-docs/develop/api/Reverse/)
- **Required Parameters**:
  - `lat`: Latitude coordinate
  - `lon`: Longitude coordinate
  - `format`: json

## 📱 Features

- **Authentication**: Simple login screen (mock implementation)
- **Current Weather**: Shows temperature, conditions, wind, humidity, and pressure
- **Hourly Forecast**: 24-hour temperature graph
- **8-Day Forecast**: Extended outlook with high/low temperatures
- **Responsive Design**: Optimized layouts for mobile, tablet, and desktop
- **Location Detection**: Automatic detection of user's location

## 🧪 Testing

The project includes extensive test coverage:

- **Unit Tests**: For business logic and data layer
- **Widget Tests**: For UI components
- **Integration Tests**: For feature workflows

Run tests with:

```bash
flutter test
```

## 🚀 Deployment

The app can be deployed to Firebase Hosting:

```bash
flutter build web --dart-define=WEATHER_BASE_URL=https://api.openweathermap.org/data/3.0/onecall --dart-define=WEATHER_API_KEY=your_api_key --dart-define=REVERSE_BASE_URL=https://nominatim.openstreetmap.org/reverse
firebase deploy --only hosting
```

## 🌐 Browser Support

The app is optimized for:
- Chrome
- Firefox
- Safari
- Edge

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgements

- [OpenWeather API](https://openweathermap.org/) for weather data
- [Nominatim](https://nominatim.org/) for geocoding services
- [Flutter Team](https://flutter.dev/) for the amazing framework