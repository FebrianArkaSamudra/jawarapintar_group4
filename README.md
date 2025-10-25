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

![Group members](/lib/IMG/Group.png)
---

## 💡 Project Overview

<<<<<<< HEAD
**JawaraPintar** is a community management system designed to simplify administrative, communication, and financial management for neighborhood or housing associations.

Built using **Flutter Web**, it includes features like user management, financial reports, message broadcasting, and more — all with a sleek sidebar-based UI.

---

## 🎨 Figma Design


The base UI design and prototype were created in **Figma**, focusing on:
- Responsive layout  
- Consistent color palette  
- Modern sidebar navigation  

🖼️ **Preview:**
![Figma Design](/lib/IMG/Figma.png)

---


## 📂 Main Features

Below is a breakdown of each feature in the app, complete with screenshots and sample Dart code.

---

### 🧭 Sidebar

Provides quick navigation across all modules and collapses for compact view.

🖼️ **Screenshot:**

![Sidebar](/lib/IMG/Sidebar.png)

### 📊 Dashboard

The **Dashboard** serves as the main overview of the entire JawaraPintar system.  
It displays quick statistics such as the number of residents, total income, expenses, and recent activity.  
This section helps admins monitor community data efficiently using visual cards and charts.

🖼️ **Screenshot:**  
![Dashboard](/lib/IMG/Dashboard.png)

```dart
class KegiatanScreen extends StatelessWidget {
  const KegiatanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F7F7),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top: 2 cards side by side, responsive
            LayoutBuilder(
              builder: (context, constraints) {
                final double maxWidth = constraints.maxWidth;
                final double spacing = 16;
                final int columns = maxWidth >= 900 ? 2 : 1;
                final double cardWidth =
                    (maxWidth - (columns - 1) * spacing) / columns;
                return Wrap(
                  spacing: spacing,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: Card(
                        color: const Color(0xFFDFF0FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
```
=======
For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# jawarapintar_group4
>>>>>>> 2f8857adc5d11aa6ff7d7f0581f5114229d7da5b

## Hammam Taek
>>>>>>> 8631290c6f3983e5b9d182dbf1d96a36fad8a3ed
