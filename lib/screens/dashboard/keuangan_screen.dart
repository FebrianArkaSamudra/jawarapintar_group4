import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class KeuanganScreen extends StatelessWidget {
  const KeuanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF7F7F7),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Statistik cards (stacked vertically on mobile)
            _StatCard(
              title: 'Total Pemasukan',
              value: '50 jt',
              color: const Color(0xFFCCE2FF),
              icon: Icons.account_balance_wallet_outlined,
            ),
            const SizedBox(height: 12),
            _StatCard(
              title: 'Total Pengeluaran',
              value: '2.1 rb',
              color: const Color(0xFFCFFFE2),
              icon: Icons.money_off_csred_outlined,
            ),
            const SizedBox(height: 12),
            _StatCard(
              title: 'Jumlah Transaksi',
              value: '4',
              color: const Color(0xFFFFF9CC),
              icon: Icons.bar_chart_outlined,
            ),
            const SizedBox(height: 16),

            // Grafik bar pemasukan
            _ChartCard(
              title: 'Pemasukan per Bulan',
              color: const Color(0xFFF3E6FF),
              child: _BarChartSample(
                barColor: Colors.blueAccent,
                maxY: 60,
                data: [0, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50],
                labels: ['Agu', '', '', '', '', '', '', '', '', '', '', 'Okt'],
              ),
            ),
            const SizedBox(height: 16),

            // Grafik bar pengeluaran
            _ChartCard(
              title: 'Pengeluaran per Bulan',
              color: const Color(0xFFFFE6EA),
              child: _BarChartSample(
                barColor: Colors.redAccent,
                maxY: 2.2,
                data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.1],
                labels: ['Okt'],
              ),
            ),
            const SizedBox(height: 16),

            // Pie chart pemasukan
            _ChartCard(
              title: 'Pemasukan Berdasarkan Kategori',
              color: const Color(0xFFCCE2FF),
              child: _PieChartSample(
                sections: [
                  PieChartSectionData(
                    color: Colors.orangeAccent,
                    value: 100,
                    title: '100%',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  PieChartSectionData(
                    color: Colors.redAccent,
                    value: 0,
                    title: '',
                  ),
                ],
                legend: const ['Dana Bantuan Pemerintah', 'Pendapatan Lainnya'],
              ),
            ),
            const SizedBox(height: 16),

            // Pie chart pengeluaran
            _ChartCard(
              title: 'Pengeluaran Berdasarkan Kategori',
              color: const Color(0xFFCFFFE2),
              child: _PieChartSample(
                sections: [
                  PieChartSectionData(
                    color: Colors.redAccent,
                    value: 100,
                    title: '100%',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
                legend: const ['Pemeliharaan Fasilitas'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3F6FAA),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F6FAA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Color color;
  final Widget child;
  const _ChartCard({
    required this.title,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.edit, color: Colors.blue.shade700, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3F6FAA),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(height: 180, child: child),
          ],
        ),
      ),
    );
  }
}

class _BarChartSample extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final Color barColor;
  final double maxY;
  const _BarChartSample({
    required this.data,
    required this.labels,
    required this.barColor,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int idx = value.toInt();
                if (idx < labels.length && labels[idx].isNotEmpty) {
                  return Text(
                    labels[idx],
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (int i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i],
                  color: barColor,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _PieChartSample extends StatelessWidget {
  final List<PieChartSectionData> sections;
  final List<String> legend;
  const _PieChartSample({required this.sections, required this.legend});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 24,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (int i = 0; i < legend.length; i++)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: sections[i].color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      legend[i],
                      style: const TextStyle(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
