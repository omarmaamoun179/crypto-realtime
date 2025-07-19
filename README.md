# CryptoRealtime

A Flutter application for real-time cryptocurrency price tracking and live updates.

---

## Overview

**CryptoRealtime** is a mobile application built with Flutter that allows users to track the prices of top cryptocurrencies (such as Bitcoin, Ethereum, XRP, and more) in real time using WebSocket technology. The app features a modern, user-friendly interface and targets anyone interested in crypto trading and digital asset monitoring.

---

## Features

- Real-time price streaming for popular cryptocurrencies
- Automatic updates without page refresh
- Clean and modern UI with light and dark mode support
- Easy navigation and instant price change tracking
- Built on modern technologies (Flutter + WebSocket)
- Easily extensible to support more coins or new features

---

## Project Architecture & Technical Details

This project is structured using the **Clean Architecture** approach, ensuring high separation of concerns, testability, and scalability.

- **Network Service Layer:**  
  A dedicated network service is implemented for handling all API requests. This abstracts network logic away from the business logic and UI layers, ensuring code maintainability and easy integration of new APIs.

- **Exception Handling:**  
  All API errors and unexpected responses are managed through a robust exception handling mechanism, providing clear error messages and a more stable user experience.

- **Dependency Injection:**  
  The project uses a custom `Injector` class to handle dependency injection. This is built using the Singleton and Flyweight design patterns, which allows for efficient memory usage and global access to shared instances such as data sources and repositories.

- **State Management:**  
  Bloc and Cubit are utilized for managing the various application states, enabling clear separation between the presentation and business logic layers. This ensures that the app remains responsive and easy to maintain as it grows.

- **WebSocket Integration:**  
  Real-time data is provided using the `web_socket_channel` package, allowing the app to establish and maintain WebSocket connections for live cryptocurrency price updates. The received data is displayed instantly to the user without the need for manual refresh.

- **Code Modularity:**  
  The codebase is highly modular, making it easy to add new features, refactor components, and maintain the application over time.


- **Performance:**  
  Efficient memory management and reactive UI updates contribute to fast performance and a smooth user experience, even with frequent real-time data updates.

---

## Requirements

- Flutter 3.29.3 
- Android/iOS device or emulator


---

## Screenshots

<div align="center">
  
  <img src="screenshot/Simulator Screenshot - iPhone 16 Pro Max - 2025-07-19 at 14.25.34.png" alt="App Screenshot 1" width="300"/>
  <img src="screenshot/Simulator Screenshot - iPhone 16 Pro Max - 2025-07-19 at 14.26.21.png" alt="App Screenshot 2" width="300"/>
  <img src="screenshot/Simulator Screenshot - iPhone 16 Pro Max - 2025-07-19 at 14.26.43.png" alt="App Screenshot 3" width="300"/>

</div>

---


## License

This project is open-source and available under the [MIT License](LICENSE).


---
# crypto-realtime
