# 🏡 JawaraPintar

A modern **Flutter Web Application** built for smart community management.

## 👥 Team Members

| Name | NIM |
|------|------|
| Febrian Arka Samudra | 2341720066 |
| Hammam Abdullah Saeed Bin Ghaleb | 2341720203 |
| Mikaila Kafka Akmalsyah | 2341720223 |
| Muhammad Rizal Al Baihaqi | 2341720225 |
| Yuma Akhunza Kausar Putra | 2341720259 |

---

## 💡 Project Overview

**JawaraPintar** is a community management system designed to simplify administrative, communication, and financial management for neighborhood or housing associations.

Built using **Flutter Web**, it includes features like user management, financial reports, message broadcasting, and more — all with a sleek sidebar-based UI.

---

 ---

## 🗓️ Project Feature Progress

Here’s the detailed breakdown of all main features developed for **Jawara Pintar**, including team assignments, deadlines, and completion status.

| 🧩 Feature Name | 👥 Assigned To | 📅 Deadline | ✅ Status |
|-----------------|----------------|--------------|-----------|
| 😊 Sidebar | Yuma Akhunza K.P, Baws, Febrian Arka, Hammam Abdullah | October 14–25, 2025 | 🟢 Done |
| 🏠 Dashboard | Baws | October 14, 2025 | 🟢 Done |
| 🎨 Design Figma | Yuma Akhunza K.P | October 14, 2025 | 🟢 Done |
| 🔑 Pengeluaran | Febrian Arka | October 16, 2025 | 🟢 Done |
| 👤 Profil Admin | Hammam Abdullah | October 18–21, 2025 | 🟢 Done |
| ⚙️ Manajemen Pengguna | Hammam Abdullah | October 18, 2025 | 🟢 Done |
| 💬 Pesan Warga | Yuma Akhunza K.P | October 19, 2025 | 🟢 Done |
| 🌟 Main Features | Baws, Febrian Arka | October 19, 2025 | 🟢 Done |
| 📊 Laporan Keuangan | Febrian Arka | October 20, 2025 | 🟢 Done |
| 📢 Kegiatan & Broadcast | Febrian Arka | October 20, 2025 | 🟢 Done |
| 🔗 Channel Transfer | Hammam Abdullah | October 20, 2025 | 🟢 Done |
| 👨‍👩‍👧‍👦 Mutasi Keluarga | Mikaila Kafka Akmalsyah | October 21, 2025 | 🟢 Done |
| 💵 Pemasukan | Baws | October 21, 2025 | 🟢 Done |
| 🏡 Data Warga & Rumah | Baws | October 22, 2025 | 🟢 Done |
| 🧍‍♂️ Penerimaan Warga | Yuma Akhunza K.P | October 23, 2025 | 🟢 Done |
| 📜 Log Aktivitas | Mikaila Kafka Akmalsyah | October 23, 2025 | 🟢 Done |
| 🔐 Login Page | Febrian Arka Samudra | October 25, 2025 | 🟢 Done |
| 🧩 Fixing Layouts | Hammam Abdullah | October 25, 2025 | 🟢 Done |

---

### 💼 Summary
All UI features for **Jawara Pintar** were completed 
Each team member contributed to their assigned modules, ensuring:
- UI consistency across screens  
- Full feature integration
- Responsive layout and smooth navigation  

🎯 **Project Status:** 100% Complete

---



## 📂 Main Features

Below is a breakdown of each feature in the app, complete with screenshots and sample Dart code.

---
### 🧭 Login & Sidebar

Provides quick navigation across all modules and collapses for compact view.

🖼️ **Displaying the feature:**

![alt text](lib/IMG/Login.gif)

### 📊 Dashboard

The **Dashboard** The Dashboard serves as the main overview of the entire JawaraPintar system.
It displays quick statistics such as the number of residents (9 people from 7 families), total income (50 million), total expenses (2,100), community activities (1 event), demographic breakdowns, and financial trends.
This section helps admins monitor community data efficiently using visual cards, pie charts, and bar graphs that cover three key areas: Kegiatan (activity management and event tracking), Kependudukan, and Keuangan (financial transactions with income and expense analysis).

🖼️ **Displaying the feature:** 
![alt text](lib/IMG/Dashboard.gif)
---

## 👨‍👩‍👧‍👦 Data Warga & Rumah

🖼️ **Displaying the feature:**
![alt text](lib/IMG/data_warga.gif)

**Description:**  
The Data Warga & Rumah section serves as the comprehensive resident and housing management system for the community.
It displays detailed information such as family data (7 families total), resident profiles (9 residents), and housing inventory (10 properties with occupancy status).
This section helps admins efficiently manage community members and properties using filterable data tables, detailed profile views, and CRUD operations (Create, Read, Update, Delete) across four main subsections: Data Warga (resident database with NIK, family relations, gender, and domicile/life status), Data Keluarga (family units showing head of household, address, and ownership status), Data Rumah (property listings with addresses and availability), and Tambah Warga/Rumah (forms to register new residents or add new properties to the system).

---
## 📥 Pemasukan

🖼️ **Displaying the feature:**
![alt text](lib/IMG/pemasukan.gif)

**Description:**  

The Pemasukan section serves as the comprehensive income management system for the community.
It displays detailed financial information such as contribution categories (8 types including monthly and special fees), non-contribution income records (4 transactions totaling approximately 50 million), and billing status for active families.
This section helps admins efficiently manage community revenue through filterable transaction tables, contribution management, and billing operations across five main subsections: Kategori Iuran (contribution categories with monthly/special fee types and customizable amounts), Tagih Iuran (billing tool to charge all active families for selected contributions with specific dates), Tagihan (billing records showing payment status, family details, and period tracking with PDF export capability), Daftar Pemasukan (non-contribution income list with date range and category filters), and Tambah Pemasukan (form to record new income entries with proof of transaction upload support).

---

## 📤 Pengeluaran

🖼️ **Displaying the feature:**
![alt text](lib/IMG/pengeluaran.gif)

**Description:**  
The **Pengeluaran** module manages all community expense records, displaying a list of past expenditures complete with dates, descriptions, and total amounts. Users can search through existing data, view detailed information for each record, and add new entries through the **Tambah** form, which provides input fields for date, description, expense category, and total cost — ensuring accurate and organized financial tracking.

---

## 📊 Laporan Keuangan

🖼️ **Displaying the feature:**
![alt text](lib/IMG/laporan_keuangan.gif)

**Description:**  
The **Laporan Keuangan** module provides a complete financial overview of all transactions within the system. It consists of three main sections — **Semua Laporan**, **Laporan Pemasukan**, and **Laporan Pengeluaran** — allowing admins to view total income, expenses, and combined summaries in one place. Each report shows detailed records with amounts, categories, and timestamps, and the **Cetak Laporan** option enables exporting financial data into printable PDF format for easy reporting and documentation.

---

## 📢 Kegiatan & Broadcast

🖼️ **Displaying the feature:**
![alt text](lib/IMG/kegiatan_broadcast.gif)

**Description:**  
The kegiatan_broadcast folder contains the UI for managing broadcasts/events: responsive list screens that render card-based items on mobile and table-style rows on larger screens, add/edit forms, and a centered card-style detail view; items are passed as simple Map<String,String> objects, and a reusable FilterDialog returns {'query','kategori'} via Navigator.pop for local filtering recommend consolidating duplicate detail widgets and extracting the filter dialog to a single reusable file for maintainability.

---

## 💬 Pesan Warga

🖼️ **Displaying the feature:**
![alt text](lib/IMG/Pesan_warga.gif)

**Description:**  
The **Pesan Warga** module serves as a communication channel between residents and administrators, allowing users to submit messages, complaints, or suggestions directly through the system. Each message includes the sender’s name, submission date, and a status indicator — **Diterima**, **Pending**, or **Ditolak** — providing clear visibility of message progress. Users can also filter messages by status for easier tracking. Admins can review each submission, manage responses, and maintain records for transparency and follow-up actions. This feature helps ensure that every resident’s voice is acknowledged and processed efficiently within the community management system.

---

## 🧍‍♂️ Penerimaan Warga

🖼️ **Displaying the feature:**
![alt text](lib/IMG/penerimaan_warga.gif)

**Description:**  
The **Penerimaan Warga** feature manages the process of recording and tracking new resident registrations. Each entry includes essential information such as **NIK**, **email**, and **gender**, displayed neatly in separate cards. Every resident’s registration is tagged with a status — **Diterima**, **Pending**, or **Ditolak** — to indicate their current approval stage. The system also provides a **filter** option, allowing users or admins to easily sort and review applications based on their status. This module ensures a transparent and organized approach to monitoring resident acceptance within the community database.

---

## 🔁 Mutasi Keluarga

🖼️ **Displaying the feature:**
![alt text](lib/IMG/mutasi_keluarga.gif)

**Description:**  
The Family Mutation feature tracks family relocations within or outside an administrative area. The list page displays mutation records with key details like date, family name, and mutation type, while the add page allows users to record new moves with reasons and dates. This ensures accurate population data for better administrative coordination.

---

## 🧾 Activity Log

🖼️ **Displaying the feature:**
![ActivityLog](/lib/IMG/activity_log.gif)

**Description:**  
The **Activity Log** feature serves as a centralized monitoring tool that records all system actions within Jawara Pintar. It logs activities such as broadcasts, billing updates, and data modifications, showing details like execution date, description, and responsible user. This ensures transparency, strengthens security oversight, and maintains accountability across all administrative operations.

---

## ⚙️ Manajemen Pengguna

🖼️ **Displaying the feature:**  
![alt text](lib/IMG/Manajemen_pengguna.gif)

**Description:**  
The **Manajemen Pengguna** module allows admins to manage user accounts efficiently within the system. Through the **Daftar Pengguna** screen, all registered users are displayed in an organized list showing their **name**, **email**, and **status** (such as *Diterima*).  

This feature provides a **search bar** and **filter option** for quick user lookup, making it easier to navigate even with large datasets. Each user card includes a contextual **menu** (three-dot button) offering key actions:
- 🔍 **Lihat Detail** – View complete information about the selected user.  
- ✏️ **Edit** – Modify user data directly from the same interface.  
---

## 🔄 Channel Transfer

🖼️ **Displaying the feature:**  
![alt text](lib/IMG/channel_transfer.gif)

**Description:**  
The Channel module manages payment and transfer channels such as banks, e-wallets, and QRIS. It features a list view with icons, account details, and color-coded status badges, plus an add/edit form with file picker integration for QR and thumbnail uploads. Users can create, edit, or delete channels with confirmation dialogs. Icons adjust by type (Bank, E-Wallet, QRIS), and forms validate inputs before saving.

## 🔄 User Profile

🖼️ **Displaying the feature:**  
![alt text](lib/IMG/profile.gif)

**Description:**  
_Explain how this feature enables users to transfer data or information between channels, ensuring smooth coordination and communication._

---

## 🎨 Figma Design


The base UI design and prototype were created in **Figma**, focusing on:
- Responsive layout  
- Consistent color palette  
- Modern sidebar navigation 

---

## ⚙️ Tech Stack

- **Framework:** Flutter  
- **Database:** (UI)  
- **Backend:** (not yet)  
- **UI Framework:** Material Design + Custom Widgets  

---

## 🚀 How to Run

```bash
# Clone the repository
git clone https://github.com/yourusername/jawara_pintar.git

# Navigate into the project directory
cd jawara_pintar

# Get dependencies
flutter pub get

# Run the app
flutter run