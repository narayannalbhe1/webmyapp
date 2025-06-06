import 'package:flutter/material.dart';
import 'package:webmyapp/Home/MyHomePage.dart';

class ReportCenterScreen extends StatefulWidget {
  const ReportCenterScreen({super.key});

  @override
  State<ReportCenterScreen> createState() => _ReportCenterScreenState();
}

class _ReportCenterScreenState extends State<ReportCenterScreen> {
  // Report options
  List<Map<String, String>> reportsList = [
    {"title": "Portfolio Summary"},
    {"title": "Sharma Family"},
    {"title": "Since Inception"},
  ];

  // Previously generated reports
  List<Map<String, String>> generatedReportsList = [
    {
      "title": "Portfolio Summary",
      "icon": "assets/homeIcons/Round Graph.png",
      "download": "assets/homeIcons/Download Minimalistic.png",
    },
    {
      "title": "Transaction Statement",
      "icon": "assets/homeIcons/Plate.png",
      "download": "assets/homeIcons/Download Minimalistic.png",
    },
    {
      "title": "Statements of Account",
      "icon": "assets/homeIcons/Bill List.png",
      "download": "assets/homeIcons/Download Minimalistic.png",
    },
    {
      "title": "Capital Gains",
      "icon": "assets/homeIcons/Plate.png",
      "download": "assets/homeIcons/Download Minimalistic.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Reports Center",style: TextStyle( fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.blue, size: 18),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D47A1).withOpacity(0.1), // Dark Blue
              Color(0xFF1976D2).withOpacity(0.2), // Medium Blue
              Color(0xFF42A5F5).withOpacity(0.6), // Light Blue
              Color(0xFF1976D2).withOpacity(0.2), // Medium Blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose a report type and click 'Generate Report' to view detailed information",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(height: 20),

              Column(
                children: [
                  blueOutlinedContainer("Portfolio Summary", context),
                  SizedBox(height: 08),
                  Text(
                    "Overview of your current investment holdings and their performance.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  SizedBox(height: 12),
                  blueOutlinedContainer("Sharma Family", context),

                  SizedBox(height: 12),

                  blueOutlinedContainer("Since Inception", context),
                ],
              ),

              const SizedBox(height: 40),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Portfolio image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/Icons/portfolio_summary.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Title Row
                    Row(
                      children: const [
                        Text(
                          "Portfolio Summary Sharma Family",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget blueOutlinedContainer(String title, BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.blue, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
