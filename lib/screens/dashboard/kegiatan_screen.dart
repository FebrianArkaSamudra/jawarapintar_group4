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
            // --- TOP SECTION: Responsive stat cards ---
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
                    // Total Kegiatan
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

                    // Kegiatan per Kategori (improved & mobile-friendly)
                    SizedBox(
                      width: cardWidth,
                      child: Card(
                        color: const Color(0xFFEFFFF8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '🗂️ Kegiatan per Kategori',
                                style: TextStyle(
                                  color: Color(0xFF2255A4),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  width: 260,
                                  height: 180,
                                  child: PieChart(
                                    PieChartData(
                                      sections: [
                                        PieChartSectionData(
                                          color: Colors.blue,
                                          value: 100,
                                          title: '100%',
                                          radius: 60,
                                          titleStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        PieChartSectionData(
                                          color: Colors.green,
                                          value: 0,
                                          title: '',
                                        ),
                                        PieChartSectionData(
                                          color: Colors.orange,
                                          value: 0,
                                          title: '',
                                        ),
                                        PieChartSectionData(
                                          color: Colors.yellow,
                                          value: 0,
                                          title: '',
                                        ),
                                        PieChartSectionData(
                                          color: Colors.red,
                                          value: 0,
                                          title: '',
                                        ),
                                        PieChartSectionData(
                                          color: Colors.purple,
                                          value: 0,
                                          title: '',
                                        ),
                                        PieChartSectionData(
                                          color: Colors.lightBlue,
                                          value: 0,
                                          title: '',
                                        ),
                                      ],
                                      centerSpaceRadius: 45,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 10,
                                runSpacing: 6,
                                children: const [
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

            // --- MIDDLE SECTION: Two horizontal cards ---
            LayoutBuilder(
              builder: (context, constraints) {
                final bool isMobile = constraints.maxWidth < 600;
                return isMobile
                    ? Column(
                        children: [
                          _buildTimeCard(),
                          const SizedBox(height: 12),
                          _buildResponsibleCard(),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _buildTimeCard()),
                          const SizedBox(width: 16),
                          Expanded(child: _buildResponsibleCard()),
                        ],
                      );
              },
            ),

            const SizedBox(height: 16),

            // --- BOTTOM SECTION: Bar Chart (fixed overflow) ---
            Card(
              color: const Color(0xFFFFE6F0),
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
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isMobile = constraints.maxWidth < 600;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: isMobile ? 400 : constraints.maxWidth,
                            height: isMobile ? 200 : 250,
                            child: BarChart(
                              BarChartData(
                                maxY: 1.2,
                                barTouchData: BarTouchData(enabled: false),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 32,
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    axisNameSize: 45,
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                            return value == 0
                                                ? Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      Text(
                                                        'Okt',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        'total : 1',
                                                        style: TextStyle(
                                                          fontSize: 11,
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
                                        width: isMobile ? 60 : 100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ],
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
                        );
                      },
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

  // --- Helper cards ---
  Widget _buildTimeCard() {
    return Card(
      color: const Color(0xFFFFF4CC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            Text('Sudah Lewat: 1', style: TextStyle(fontSize: 14)),
            Text('Hari Ini: 0', style: TextStyle(fontSize: 14)),
            Text('Akan Datang: 0', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsibleCard() {
    return Card(
      color: const Color(0xFFF4E8FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }
}

// --- Legend Dot widget ---
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
