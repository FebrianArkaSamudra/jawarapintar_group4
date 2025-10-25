import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class KependudukanScreen extends StatelessWidget {
  const KependudukanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final EdgeInsets contentPadding = EdgeInsets.all(isMobile ? 12 : 16);
    final double cardPadding = isMobile ? 16 : 24;
    final double pieSize = isMobile ? 100 : 140;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        padding: contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: Stat cards
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: '👪 Total Keluarga',
                        value: '7',
                        bgColor: const Color(0xFFDFF0FF),
                        textColor: const Color(0xFF2255A4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: '👥 Total Penduduk',
                        value: '9',
                        bgColor: const Color(0xFFDFFFEF),
                        textColor: const Color(0xFF2B7A4B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Dynamic grid for pie charts
            LayoutBuilder(
              builder: (context, constraints) {
                final double spacing = 12;
                final int columns = isMobile ? 1 : 2;
                final double cardWidth =
                    (constraints.maxWidth - (columns - 1) * spacing) / columns;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '⚪ Status Penduduk',
                        color: const Color(0xFFFFF4CC),
                        pieSize: pieSize,
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: 78,
                            title: 'Aktif 78%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.orange,
                            value: 22,
                            title: 'Nonaktif 22%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        legend: const [
                          _LegendDot(color: Colors.green, label: 'Aktif'),
                          _LegendDot(color: Colors.orange, label: 'Nonaktif'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '♀️ Jenis Kelamin',
                        color: const Color(0xFFF4E8FF),
                        pieSize: pieSize,
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 89,
                            title: 'Laki-laki 89%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: 11,
                            title: 'Perempuan 11%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        legend: const [
                          _LegendDot(color: Colors.blue, label: 'Laki-laki'),
                          _LegendDot(color: Colors.red, label: 'Perempuan'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '💼 Pekerjaan Penduduk',
                        color: const Color(0xFFFFE6F0),
                        pieSize: pieSize,
                        sections: [
                          PieChartSectionData(
                            color: Colors.purple,
                            value: 100,
                            title: 'Lainnya 100%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        legend: const [
                          _LegendDot(color: Colors.purple, label: 'Lainnya'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '🦸‍♂️ Peran dalam Keluarga',
                        color: const Color(0xFFE6F0FF),
                        pieSize: pieSize,
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 78,
                            title: 'Kepala Keluarga 78%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.pink,
                            value: 11,
                            title: 'Anak 11%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            value: 11,
                            title: 'Anggota Lain 11%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        legend: const [
                          _LegendDot(
                            color: Colors.blue,
                            label: 'Kepala Keluarga',
                          ),
                          _LegendDot(color: Colors.pink, label: 'Anak'),
                          _LegendDot(
                            color: Colors.green,
                            label: 'Anggota Lain',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '🙏 Agama',
                        color: const Color(0xFFFFE6F0),
                        pieSize: pieSize,
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 50,
                            title: 'Islam 50%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: 50,
                            title: 'Katolik 50%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        legend: const [
                          _LegendDot(color: Colors.blue, label: 'Islam'),
                          _LegendDot(color: Colors.red, label: 'Katolik'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '🎓 Pendidikan',
                        color: const Color(0xFFDFFFEF),
                        pieSize: pieSize,
                        sections: [
                          PieChartSectionData(
                            color: Colors.grey,
                            value: 100,
                            title: 'Sarjana/Diploma 100%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        legend: const [
                          _LegendDot(
                            color: Colors.grey,
                            label: 'Sarjana/Diploma',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title, value;
  final Color bgColor, textColor;
  const _StatCard({
    required this.title,
    required this.value,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PieCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<PieChartSectionData> sections;
  final List<_LegendDot> legend;
  final double pieSize;

  const _PieCard({
    required this.title,
    required this.color,
    required this.sections,
    required this.legend,
    this.pieSize = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: pieSize,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: pieSize * 0.25,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 4, children: legend),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
