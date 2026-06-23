🦷 Dental Clinic App

A Flutter application for managing a dental clinic — patients, appointments, and services — built with Clean Architecture.

📱 Screenshots













✨ Features

- Patients Management — Add, view, and delete patients
- Appointments — Schedule and track appointments, mark as done
- Services — Manage clinic services with prices and durations
- Dashboard — Quick overview of total patients and today's appointments
- Local Storage — All data saved locally using Hive



🏗️ Architecture

This project follows Clean Architecture principles:

lib/
├── core/
│   ├── di/          ← Dependency Injection (get_it)
│   ├── router/      ← Navigation (GoRouter)
│   └── theme/       ← App Theme
│
└── features/
    ├── patients/
    │   ├── data/        ← Models + Repository
    │   ├── domain/      ← Entities
    │   └── presentation ← Cubit + Screens
    ├── appointments/
    └── services/


🛠️ Tech Stack

PurposePackageState Managementflutter_blocLocal Storagehive + hive_flutterDependency Injectionget_itNavigationgo_routerUnique IDsuuidModel Equalityequatable


🚀 Getting Started


Clone the repo


bashgit clone https://github.com/YOUR_USERNAME/dental_clinic_app.git
cd dental_clinic_app


Install dependencies


bashflutter pub get


Run the app


bashflutter run


👨‍💻 Author

Mohamed Tawfik
GitHub: @Mohamedtawfik7
LinkedIn:www.linkedin.com/in/mohamed-tawfik-210607407
