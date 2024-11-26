import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class ExchangeRateHistoryPage extends StatelessWidget {
  final Map<String, List<FlSpot>> _historicalData = {
    // ... (Your historical data here)
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency Exchange Rate History',
          style: GoogleFonts.libreCaslonText(color: Colors.white),
        ),
        backgroundColor: Color(0xFF566777), // Dark Blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _historicalData.entries.map((entry) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                color: const Color(0xFFF4EBE6), // Light Pink background
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.show_chart, color: Color(0xFF566777)), // Dark Blue icon
                      title: Text(
                        entry.key,
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF566777), // Dark Blue color
                        ),
                      ),
                      subtitle: Text(
                        'Historical Exchange Rates',
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 16,
                          color: Color(0xFF566777), // Dark Blue color
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      visualDensity: VisualDensity(horizontal: 0.0, vertical: -4.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200, // Height for the chart
                        child: LineChart(
                          LineChartData(
                            lineTouchData: LineTouchData(
                              enabled: true,
                              touchTooltipData: LineTouchTooltipData(
                                tooltipPadding: EdgeInsets.all(8),
                                tooltipBorder: BorderSide(color: Color(0xFF566777)),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: entry.value,
                                isStrokeCapRound: true,
                                barWidth: 4, // Line width
                                color: Color(0xFF566777), // Dark Blue line
                                dotData: FlDotData(show: false),
                              ),
                            ],
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(show: false),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: Color(0xFF566777), // Dark Blue border
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
