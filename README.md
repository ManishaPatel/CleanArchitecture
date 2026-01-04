# Flutter Clean Architecture App - Task Manager

A modern Flutter application demonstrating Clean Architecture principles with GetX state management and REST API integration. This Task Manager app allows users to create, update, delete, and track their tasks efficiently.

## 📱 Features

- ✅ **Task Management**
  - Create new tasks with title and description
  - Edit existing tasks
  - Delete tasks
  - Mark tasks as completed/pending
  - View task details

- 📊 **Task Statistics**
  - Total tasks count
  - Pending tasks count
  - Completed tasks count

- 🎨 **Modern UI/UX**
  - Beautiful Material Design 3 interface
  - Smooth animations and transitions
  - Pull-to-refresh functionality
  - Empty state handling
  - Error state handling with retry option

- 🔄 **State Management**
  - Reactive state management with GetX
  - Real-time UI updates
  - Loading states
  - Error handling

- 🏗️ **Clean Architecture**
  - Separation of concerns
  - Dependency injection
  - Testable code structure
  - Maintainable architecture

## 🛠️ Tech Stack

### Core Technologies
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language

### State Management
- **GetX** (v4.6.6) - State management, dependency injection, and routing

### Networking
- **HTTP** (v1.2.2) - HTTP client for REST API calls

### Architecture
- **Clean Architecture** - Layered architecture pattern
  - **Domain Layer**: Entities, Use Cases, Repository Interfaces
  - **Data Layer**: Models, Data Sources, Repository Implementations
  - **Presentation Layer**: Controllers, Pages, Widgets

### Additional Packages
- **Equatable** (v2.0.5) - Value equality comparison
- **JSON Annotation** (v4.9.0) - JSON serialization support

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── api_constants.dart      # API endpoints and constants
│   ├── di/
│   │   └── injection_container.dart # Dependency injection setup
│   └── errors/
│       └── failures.dart           # Error handling classes
├── data/
│   ├── datasources/
│   │   └── task_remote_data_source.dart  # Remote data source
│   ├── models/
│   │   └── task_model.dart         # Data models
│   └── repositories/
│       └── task_repository_impl.dart     # Repository implementation
├── domain/
│   ├── entities/
│   │   └── task.dart               # Business entities
│   ├── repositories/
│   │   └── task_repository.dart    # Repository interface
│   └── usecases/
│       ├── create_task.dart
│       ├── delete_task.dart
│       ├── get_task_by_id.dart
│       ├── get_tasks.dart
│       └── update_task.dart
├── presentation/
│   ├── controllers/
│   │   └── task_controller.dart    # GetX controller
│   ├── pages/
│   │   ├── add_task_page.dart
│   │   ├── edit_task_page.dart
│   │   ├── home_page.dart
│   │   └── task_detail_page.dart
│   └── widgets/
│       └── task_list_item.dart     # Reusable widgets
└── main.dart                        # App entry point
```

## 🚀 How to Run

### Prerequisites

- Flutter SDK (3.10.3 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android Emulator / iOS Simulator / Physical Device

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-clean-architecture-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

   Or use your IDE's run button.

### Running on Specific Platforms

- **Android**: `flutter run -d android`
- **iOS**: `flutter run -d ios`
- **Web**: `flutter run -d chrome`
- **Windows**: `flutter run -d windows`

## 🏗️ Architecture Overview

### Clean Architecture Layers

#### 1. Domain Layer (Business Logic)
- **Entities**: Pure business objects (Task)
- **Use Cases**: Business logic operations
- **Repository Interfaces**: Contracts for data operations

#### 2. Data Layer (Data Management)
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Remote/local data sources
- **Repository Implementations**: Concrete implementations of repository interfaces

#### 3. Presentation Layer (UI)
- **Controllers**: GetX controllers managing state
- **Pages**: Screen widgets
- **Widgets**: Reusable UI components

### Dependency Flow

```
Presentation → Domain ← Data
     ↓           ↑        ↓
  GetX      Use Cases  Models
Controllers  Entities  Data Sources
```

## 🔌 API Integration

The app uses a **mock REST API service** that simulates network calls. The `TaskRemoteDataSource` includes:

- Simulated network delays
- Mock data storage
- Error handling

To integrate with a real API:

1. Update `ApiConstants` with your API endpoints
2. Modify `TaskRemoteDataSourceImpl` to make actual HTTP requests
3. Update the JSON parsing in `TaskModel.fromJson()`

Example API endpoints structure:
```
GET    /tasks          - Get all tasks
GET    /tasks/:id      - Get task by ID
POST   /tasks          - Create new task
PUT    /tasks/:id      - Update task
DELETE /tasks/:id      - Delete task
```

## 🧪 Testing

To run tests:
```bash
flutter test
```

## 📝 Code Generation

If you modify models with JSON annotations, run:
```bash
flutter pub run build_runner build
```

## 🎯 Key Features Implementation

### State Management with GetX
- Reactive variables (`RxList`, `RxBool`, `RxString`)
- Automatic UI updates
- Dependency injection
- Navigation management

### Error Handling
- Custom failure classes
- Either pattern for error handling
- User-friendly error messages
- Retry mechanisms

### Clean Code Principles
- Single Responsibility Principle
- Dependency Inversion Principle
- Separation of Concerns
- Testability

## 📸 Screenshots

_Add screenshots of your app here_

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

Built with ❤️ using Flutter and Clean Architecture

---

**Note**: This is a demonstration project showcasing Clean Architecture principles in Flutter. The API integration uses mock data for demonstration purposes.
