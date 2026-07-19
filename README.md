# 🏥 MediSync

<p align="center">
  <b>A Flutter & Firebase Healthcare Management Application</b><br>
  Securely manage your health records, appointments, medications, vaccinations, and emergency information—all in one place.
</p>

---

## 📖 Overview

MediSync is a cross-platform healthcare management application built using **Flutter** and **Firebase**. It serves as a digital health companion by allowing users to securely manage medical information, generate a Health Passport PDF, receive medication reminders, and access emergency details through a QR code.

This project was developed as a **Final Year Engineering Project** to demonstrate practical mobile application development using modern technologies.

---

## ✨ Features

### 👤 User Authentication
- Firebase Email Authentication
- Secure Login & Registration
- User Profile Management

### 💊 Medication Management
- Add, Edit & Delete Medications
- Daily Medication Reminders
- Local Notifications

### 📅 Appointment Management
- Schedule Doctor Appointments
- Edit/Delete Appointments
- Appointment History

### 💉 Vaccination Tracker
- Store Vaccination Records
- Track Vaccine History

### 📂 Medical Records
- Secure Medical Document Storage
- Record Management
- Organized Health Information

### 🏥 Health Passport
- Generates a professional Health Passport PDF
- Includes:
  - Personal Information
  - Medical Records
  - Medications
  - Vaccinations
  - Appointments

### 🚨 Emergency QR Card
- Generates a QR Code
- Quick access to emergency information

### 🔍 Global Search
Search across:
- Medications
- Appointments
- Vaccinations
- Medical Records

### 📊 Dashboard
- Health Overview
- Medication Count
- Appointment Count
- Vaccination Count

---

# 📱 Screenshots

> Create a folder named:

```
assets/screenshots/
```

Add your screenshots with these names:

```
login.png
dashboard.png
medications.png
appointments.png
vaccinations.png
health_passport.png
qr.png
search.png
```

Then the images will automatically appear:

| Login | Dashboard |
|-------|-----------|
| ![](assets/screenshots/login.png) | ![](assets/screenshots/dashboard.png) |

| Medications | Appointments |
|-------------|--------------|
| ![](assets/screenshots/medications.png) | ![](assets/screenshots/appointments.png) |

| Vaccinations | Health Passport |
|--------------|----------------|
| ![](assets/screenshots/vaccinations.png) | ![](assets/screenshots/health_passport.png) |

| Emergency QR | Search |
|-------------|--------|
| ![](assets/screenshots/qr.png) | ![](assets/screenshots/search.png) |

---

# 🛠 Tech Stack

### Frontend
- Flutter
- Dart
- Material Design

### Backend
- Firebase Authentication
- Cloud Firestore

### Packages Used

- firebase_auth
- cloud_firestore
- flutter_local_notifications
- firebase_core
- qr_flutter
- pdf
- printing
- intl
- image_picker
- shared_preferences

---

# 🏗 Architecture

```
Flutter UI
      │
      ▼
Business Logic
      │
      ▼
Firebase Authentication
      │
      ▼
Cloud Firestore
      │
      ▼
Notification Service
```

---

# 📂 Project Structure

```
lib/
│
├── models/
├── screens/
│   ├── auth/
│   ├── home/
│   ├── medication/
│   ├── appointments/
│   ├── records/
│   ├── vaccination/
│   ├── qr/
│   ├── search/
│   └── profile/
│
├── services/
├── widgets/
└── main.dart
```

---

# 🚀 Installation

Clone the repository

```bash
git clone https://github.com/srijhakrishnakumar-lgtm/MediSync.git
```

Go into the project

```bash
cd MediSync
```

Install packages

```bash
flutter pub get
```

Run the application

```bash
flutter run
```

---

# 🔒 Security

Sensitive files such as:

- `key.properties`
- `upload-keystore.jks`
- Firebase signing files

are excluded from the public repository using `.gitignore`.

---

# 🚀 Future Enhancements

- AI Health Assistant
- Medicine Interaction Checker
- Cloud File Upload
- Wearable Device Integration
- Doctor Portal
- Family Health Sharing
- Multi-language Support

---

# 📚 Development Progress

The project was developed over multiple phases including:

- UI Design
- Firebase Integration
- Authentication
- CRUD Operations
- Notification System
- Health Passport PDF
- QR Emergency Card
- Search Functionality
- Testing & Release Build

---

# 👨‍💻 Author

**Srijha K**

Final Year Engineering Student

GitHub:
https://github.com/srijhakrishnakumar-lgtm

---

# ⭐ Support

If you found this project useful, consider giving it a ⭐ on GitHub!

---

## 📄 License

This project is developed for educational purposes as a Final Year Engineering Project.
