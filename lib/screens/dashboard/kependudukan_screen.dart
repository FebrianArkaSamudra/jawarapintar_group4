import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class KependudukanScreen extends StatelessWidget {
  const KependudukanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F7F7),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top: 2 stat cards
            Row(
              children: [
                Expanded(
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
                            '👪 Total Keluarga',
                            style: TextStyle(
                              color: Color(0xFF2255A4),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '7',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2255A4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    color: const Color(0xFFDFFFEF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '👥 Total Penduduk',
                            style: TextStyle(
                              color: Color(0xFF2B7A4B),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '9',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B7A4B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Grid: 2 columns, 3 rows
            LayoutBuilder(
              builder: (context, constraints) {
                final double spacing = 16;
                final double maxWidth = constraints.maxWidth;
                final int columns = maxWidth > 900 ? 2 : 1;
                final double cardWidth =
                    (maxWidth - (columns - 1) * spacing) / columns;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    // Status Penduduk
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '⚪ Status Penduduk',
                        color: const Color(0xFFFFF4CC),
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: 78,
                            title: 'Aktif 78%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.orange,
                            value: 22,
                            title: 'Nonaktif 22%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
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
                    // Jenis Kelamin
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '♀️ Jenis Kelamin',
                        color: const Color(0xFFF4E8FF),
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 89,
                            title: 'Laki-laki 89%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: 11,
                            title: 'Perempuan 11%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
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
                    // Pekerjaan Penduduk
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '💼 Pekerjaan Penduduk',
                        color: const Color(0xFFFFE6F0),
                        sections: [
                          PieChartSectionData(
                            color: Colors.purple,
                            value: 100,
                            title: 'Lainnya 100%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        legend: const [
                          _LegendDot(color: Colors.purple, label: 'Lainnya'),
                        ],
                      ),
                    ),
                    // Peran dalam Keluarga
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '🦸‍♂️ Peran dalam Keluarga',
                        color: const Color(0xFFE6F0FF),
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 78,
                            title: 'Kepala Keluarga 78%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.pink,
                            value: 11,
                            title: 'Anak 11%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            value: 11,
                            title: 'Anggota Lain 11%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
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
                    // Agama
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '🙏 Agama',
                        color: const Color(0xFFFFE6F0),
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: 50,
                            title: 'Islam 50%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: 50,
                            title: 'Katolik 50%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
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
                    // Pendidikan
                    SizedBox(
                      width: cardWidth,
                      child: _PieCard(
                        title: '🎓 Pendidikan',
                        color: const Color(0xFFDFFFEF),
                        sections: [
                          PieChartSectionData(
                            color: Colors.grey,
                            value: 100,
                            title: 'Sarjana/Diploma 100%',
                            radius: 40,
                            titleStyle: const TextStyle(
                              fontSize: 14,
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

class _PieCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<PieChartSectionData> sections;
  final List<_LegendDot> legend;
  const _PieCard({
    required this.title,
    required this.color,
    required this.sections,
    required this.legend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: PieChart(
                PieChartData(sections: sections, centerSpaceRadius: 32),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(spacing: 12, runSpacing: 4, children: legend),
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
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
