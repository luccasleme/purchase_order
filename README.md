# Purchase Order Management System

## Overview

A Flutter mobile application for purchase order management, built on MVVM architecture and Firebase backend.

---

## Data Source

The app data was sourced from an Excel file containing purchase order data. The workflow:

1. **Excel Sheet** - Raw data with vendor information, order numbers, quantity, and status
2. **Converted to Dart** - Converted and processed into Dart objects
3. **Uploaded to Firebase** - Uploaded into Firestore database with the structured data

This is a sample real-world data migration scenario from pre-existing spreadsheets to a new cloud database.

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

This portfolio project showcases top-level Flutter development with MVVM 
architecture and Firebase backend integration.

















 












  