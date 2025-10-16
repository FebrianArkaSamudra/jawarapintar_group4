import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
                                '🎉 Total Kegiatan',
                                style: TextStyle(
                                  color: Color(0xFF2255A4),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2255A4),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Jumlah seluruh event yang sudah ada',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: Card(
                        color: const Color(0xFFDFFFEF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '🗂️ Kegiatan per Kategori',
                                style: TextStyle(
                                  color: Color(0xFF2255A4),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 120,
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        color: Colors.blue,
                                        value: 100,
                                        title: '100%',
                                        radius: 48,
                                        titleStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        color: Colors.green,
                                        value: 0,
                                        title: '',
                                        radius: 48,
                                      ),
                                      PieChartSectionData(
                                        color: Colors.orange,
                                        value: 0,
                                        title: '',
                                        radius: 48,
                                      ),
                                      PieChartSectionData(
                                        color: Colors.yellow,
                                        value: 0,
                                        title: '',
                                        radius: 48,
                                      ),
                                      PieChartSectionData(
                                        color: Colors.purple,
                                        value: 0,
                                        title: '',
                                        radius: 48,
                                      ),
                                      PieChartSectionData(
                                        color: Colors.red,
                                        value: 0,
                                        title: '',
                                        radius: 48,
                                      ),
                                      PieChartSectionData(
                                        color: Colors.lightBlue,
                                        value: 0,
                                        title: '',
                                        radius: 48,
                                      ),
                                    ],
                                    centerSpaceRadius: 32,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Legend
                              Wrap(
                                spacing: 12,
                                runSpacing: 4,
                                children: [
                                  _LegendDot(
                                    color: Colors.blue,
                                    label: 'Komunitas & Sosial',
                                  ),
                                  _LegendDot(
                                    color: Colors.green,
                                    label: 'Kebersihan & Keamanan',
                                  ),
                                  _LegendDot(
                                    color: Colors.orange,
                                    label: 'Keagamaan',
                                  ),
                                  _LegendDot(
                                    color: Colors.yellow,
                                    label: 'Pendidikan',
                                  ),
                                  _LegendDot(
                                    color: Colors.red,
                                    label: 'Kesehatan & Olahraga',
                                  ),
                                  _LegendDot(
                                    color: Colors.purple,
                                    label: 'Lainnya',
                                  ),
                                  _LegendDot(
                                    color: Colors.lightBlue,
                                    label: 'Lainnya',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            // Middle: 2 horizontal cards
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: const Color(0xFFFFF4CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '🍒 Kegiatan berdasarkan Waktu',
                            style: TextStyle(
                              color: Color(0xFFB97A00),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Sudah Lewat: 1',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text('Hari Ini: 0', style: TextStyle(fontSize: 14)),
                          Text(
                            'Akan Datang: 0',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    color: const Color(0xFFF4E8FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '👤 Penanggung Jawab Terbanyak',
                            style: TextStyle(
                              color: Color(0xFF6A4FB6),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text('Pak', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Bottom: wide bar chart
            Card(
              color: const Color(0xFFFDE6F0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📅 Kegiatan per Bulan (Tahun Ini)',
                      style: TextStyle(
                        color: Color(0xFFD94B7A),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 220,
                      child: BarChart(
                        BarChartData(
                          maxY: 1.2,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                      return value == 0
                                          ? Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Text(
                                                  'Okt',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  'total : 1',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox();
                                    },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(
                                  toY: 1.0,
                                  color: Colors.pinkAccent,
                                  width: 120,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ],
                              showingTooltipIndicators: [0],
                            ),
                          ],
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            getDrawingHorizontalLine: (v) => FlLine(
                              color: Colors.grey.shade300,
                              strokeWidth: 1,
                            ),
                            getDrawingVerticalLine: (v) => FlLine(
                              color: Colors.grey.shade300,
                              strokeWidth: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
