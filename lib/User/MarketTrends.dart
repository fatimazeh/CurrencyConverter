import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MarketTrendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Market Trends'),
        backgroundColor: const Color(0xFF597CFF), // Dark Blue
      ),
      backgroundColor: Colors.white, // Set the background color of the body to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            const Text(
              'Market Trends Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001F3D), // Dark Blue
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Stay updated with the latest market trends and fluctuations. Analyze the data to make informed financial decisions.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF566777), // Dark Blue
              ),
            ),
            const SizedBox(height: 16.0),
            
            // Image Section
                     
            const SizedBox(height: 16.0),
            
            // Chart Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white, // Set the container background color to white
                ),
                child: FutureBuilder<MarketData>(
                  future: fetchMarketData(), // Fetch market data
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error fetching market data'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No market data available'));
                    }

                    final data = snapshot.data!;
                    return LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: data.spots,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.red], // Gradient color
                            ),
                            isCurved: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                        titlesData: FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                        gridData: FlGridData(show: false),
                      ),
                    );
                  },
                ),
              ),
            ),
              Center(
              child: Image.asset(
                '../lib/images/Dynamic_Banner.gif', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define a class to hold market data
class MarketData {
  final List<FlSpot> spots;

  MarketData({required this.spots});
}

// Function to fetch market data
Future<MarketData> fetchMarketData() async {
  // Replace with actual API call
  await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  return MarketData(
    spots: [
      FlSpot(1, 1),
      FlSpot(2, 1.5),
      FlSpot(3, 2),
      FlSpot(4, 1.8),
    ],
  );
}