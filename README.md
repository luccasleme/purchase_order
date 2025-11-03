# Purchase Order Management System

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Overview

A Flutter mobile application for purchase order management, built on MVVM architecture and Firebase backend.

---

## Data Source

The app data was sourced from an Excel file containing purchase order data. The workflow:

1. **Excel Sheet** - Raw data with vendor information, order numbers, quantity, and status
2. **Converted to Dart** - Converted and processed into Dart objects
3. **Uploaded to Firebase** - Uploaded into Firestore database with the structured data

This is a sample real-world data migration scenario from pre-existing spreadsheets to a new cloud database.

**Important Note:** The Excel import was a **one-time data injection** to populate the application with sample data. The application itself does **not** have built-in functionality to import Excel files. All data management operations (create, read, update, delete) are performed exclusively through Firebase Firestore.

---

## Backend: Firebase

Firebase provides the complete backend stack:

- **Firebase Authentication** - email/password login-based user authentication
- **Cloud Firestore** - NoSQL database of users and orders
- **Security Rules** - server-side security rules

**Data Structure:**
```
/users/{userId}          - User profiles
/orders/allOrders        - Purchase order records
```

---

## Architecture: MVVM

This project adheres to **Model-View-ViewModel** pattern best practices with Clean Architecture.

### MVVM Layers

```
VIEW (UI)
↕
VIEWMODEL (State Management)
↕
MODEL (Business Logic + Data)
```

**Components:**
- **Model**: Domain models, use cases, repositories, Firebase data sources
- **View**: Flutter pages and widgets
- **ViewModel**: Riverpod StateNotifiers of state

### Project Structure

```
lib/
├── core/                  # Shared infrastructure
```
├── features/             # Feature modules
│   ├── auth/
│   │   ├── data/         # Firebase implementation
│   │   ├── domain/       # Business logic
│   │   └── presentation/ # UI + ViewModel
│   └── orders/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── routes/               # Navigation

---

## Technical Stack

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **Architecture**: MVVM + Clean Architecture
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Backend**: Firebase (Auth + Firestore)
- **Error Handling**: Either pattern (dartz)

---

## Features

- Email/password authentication
- Auto-login with secure credential storage
- Order dashboard with status grouping
- Search and filter functionality
- Order detail views
- Update order status (Open/Close)
- Real-time Firebase synchronization

---

## Key Implementations

**MVVM Pattern**
- Decoupled UI, state, and business logic
- Immutable state objects with copyWith pattern
- Reactive UI updates with Riverpod

**Security**
- Firebase Authentication
- Firestore Security Rules
- Encrypted local storage

**Design Patterns**
- Repository Pattern
- Use Case Pattern
- Dependency Injection
- Immutable State

---

## Error Logging

**Status: Not Implemented**

The application currently **does not implement** a centralized error logging system. This is a planned feature for future versions.

**Current Error Handling:**
- Errors are handled locally using the Either pattern (dartz library)
- Failed operations return `Left(Failure)` with error messages
- Errors are displayed to users through UI feedback (banners, dialogs)
- No error persistence or remote logging occurs

**Planned Technologies:**
- Firebase Crashlytics for crash reporting
- Cloud Functions for server-side error processing
- Custom error aggregation dashboard
- User session context tracking

For now, all error handling remains local and transient within the application lifecycle.

---

## Getting Started

### Prerequisites

Before running this project, ensure you have:

- **Flutter SDK**: Version 3.x or higher ([Install Flutter](https://flutter.dev/docs/get-started/install))
- **Dart SDK**: Version 3.x or higher (bundled with Flutter)
- **Firebase Account**: Free tier is sufficient ([Create Firebase Account](https://firebase.google.com/))
- **IDE**: VS Code or Android Studio with Flutter/Dart plugins
- **Git**: For cloning the repository
- **FlutterFire CLI**: For Firebase configuration (`dart pub global activate flutterfire_cli`)

### Setup Instructions

#### 1. Clone the Repository

```bash
git clone https://github.com/luccasleme/purchase_order.git
cd purchase_order
```

#### 2. Install Dependencies

```bash
flutter pub get
```

#### 3. Firebase Configuration

Create a new Firebase project and configure the following services:

**a) Create Firebase Project**
- Go to [Firebase Console](https://console.firebase.google.com/)
- Click "Add project" and follow the setup wizard
- Enable Google Analytics (optional)

**b) Enable Firebase Services**
- **Authentication**: Enable Email/Password sign-in method
- **Firestore Database**: Create database in production mode (or test mode for development)

**c) Configure FlutterFire**

Run the FlutterFire CLI to automatically configure your app:

```bash
flutterfire configure
```

This will:
- Prompt you to select your Firebase project
- Generate platform-specific configuration files
- Update [firebase.json](firebase.json) and [lib/firebase_options.dart](lib/firebase_options.dart)

**Note:** The [firebase.json](firebase.json) file contains only public project identifiers (projectId, appId), not sensitive credentials. Firebase authentication happens through SDK initialization.

**d) Firestore Data Structure**

Create the following collections in Firestore:

```
/users/{userId}          - User profiles (auto-created on signup)
/orders/allOrders        - Purchase order records (requires manual data import)
```

For sample data, you can manually add documents or use the Firebase Console to import JSON data.

#### 4. Run the Application

**For Android:**
```bash
flutter run
```

**For iOS (requires macOS):**
```bash
flutter run
```

**For specific device:**
```bash
flutter devices              # List available devices
flutter run -d <device-id>   # Run on specific device
```

#### 5. Create Test Account

On first launch:
1. Click "Sign Up" on the login screen
2. Enter email and password
3. The app will create a user profile in Firestore automatically

### Troubleshooting

- **"Firebase not initialized"**: Ensure `flutterfire configure` was run successfully
- **"No orders found"**: The orders collection needs to be populated with sample data
- **Build errors**: Run `flutter clean && flutter pub get` and try again
- **iOS CocoaPods issues**: Run `cd ios && pod install && cd ..`

---

## Portfolio Screenshots

This section showcases the key features and user interface of the Purchase Order Management application.

### 1. Dashboard Overview
<img src="docs/screenshots/dashboard.png" width="300" alt="Dashboard showing order statistics">

The main dashboard displays comprehensive order statistics:
- **Order Status Categories**: Open (15), Closed (1023), Incomplete data (1)
- **Billing Status**: Fully Billed (3972), Pending Bill (179), Pending Receipt (20)
- **Receipt Status**: Partially Received (14), Pending Billing/Partially Received (45)

This dashboard provides users with a real-time overview of all purchase orders and their current states, enabling quick decision-making and workflow management.

### 2. Authentication Flow
<img src="docs/screenshots/login.png" width="300" alt="Login screen">
<img src="docs/screenshots/signup.png" width="300" alt="Sign up screen">

Secure authentication system featuring:
- Email/password login
- "Remember me" functionality with secure local storage
- Account creation flow
- Password visibility toggle
- Firebase Authentication integration

### 3. Order Management
<img src="docs/screenshots/order_list.png" width="300" alt="Fully billed orders list">
<img src="docs/screenshots/order_search.png" width="300" alt="Search functionality in action">

The order list view includes:
- **Real-time Search**: Quick search by order ID or vendor name (demonstrated with "5030" query filtering results)
- **Dynamic Filtering**: Search results update instantly as users type
- **Order Cards**: Each displaying Order ID, Vendor Name, and Date
- **Status-based Filtering**: View by Fully Billed, Pending Bill, etc.
- **Scrollable List**: Easy navigation through large datasets
- **Search Persistence**: Search bar available across all order status views

### 4. Order Details
<img src="docs/screenshots/order_detail.png" width="300" alt="Order detail screen">

Detailed order view showing:
- **Order Status**: Fully Billed (displayed in green)
- **Order Information**: Quantity ordered (1)
- **Vendor Details**: Name (Carbon Chemistry Ltd.), Entity ID (827155), Document Number (PO5030)
- **Quantities**: Qty Billed (1), Qty Received (1)
- **Action Button**: "Close" button to update order status
- **Date**: Order date (11 OCT 2018)

### 5. Status Update Flow
<img src="docs/screenshots/success_banner.png" width="300" alt="Success banner after closing order">

The status update demonstrates:
- **Loading state**: Visual feedback during Firebase transaction
- **Success notification**: Bottom banner confirming "Order closed successfully"
- **Real-time sync**: Immediate reflection in dashboard statistics (Open count decreased from 15 to 14, Closed increased from 1022 to 1023)

---

## User Workflow Demonstrated

The screenshots above illustrate a complete user journey:

1. **Login** → User authenticates with credentials
2. **Dashboard** → User views overall order statistics
3. **Order List** → User searches and browses orders by status
4. **Order Detail** → User reviews specific order information
5. **Status Update** → User closes an order, triggering a Firebase update
6. **Success Feedback** → User receives confirmation and sees updated dashboard

This workflow showcases the application's ability to handle real-world purchase order management tasks efficiently.

---

This portfolio project showcases professional Flutter development with MVVM
architecture and Firebase backend integration.

















 












  