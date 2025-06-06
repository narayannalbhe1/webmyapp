import 'package:flutter/material.dart';
import 'package:webmyapp/Home/MyHomePage.dart';
import 'package:webmyapp/Home/ReportCenterScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Report options
  List<Map<String, String>> reportsList = [
    {
      "title": "Portfolio Summary",
      "subtitle":
          "Overview of your current investment holdings and their performance.",
    },
    {
      "title": "Capital Gains",
      "subtitle":
          "Summary of gains/losses generated from your investments for filing your ITR.",
    },
    {
      "title": "Cash Flow",
      "subtitle":
          "View cash inflows & outflows to your folio from your registered bank account.",
    },
    {
      "title": "Transaction Statement",
      "subtitle":
          "Record of all investment transactions for each holding in your portfolio.",
    },
    {
      "title": "Statement of Accounts",
      "subtitle":
          "Comprehensive report on a fund's key information & performance.",
    },
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
      "": "assets/homeIcons/Download Minimalistic.png",
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
              MaterialPageRoute(builder: (context) => ReportCenterScreen()),
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
              Color(0xFF2A061E),
              Color(0xFF3B0724).withOpacity(0.4), // Deep Dark Plum
              Color(0xFFFFA800).withOpacity(0.2) ,
              Color(0x573A0400) // Very Dark Brownish Yellow
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 08),

              Text(
                "Which report do you want to generate today?",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Vertical Report List
              Expanded(
                child: ListView.builder(
                  itemCount: reportsList.length,
                  itemBuilder: (context, index) {
                    var item = reportsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            color: Colors.blue,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                item["title"]!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),),
                              SizedBox(height: 5),
                              Text(
                                item["subtitle"]!,
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Divider(thickness: 0.8,color: Colors.grey,),
              SizedBox(height: 08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Previously Generated Reports",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("View All", style: TextStyle(color: Colors.blue)),
                ],
              ),

              const SizedBox(height: 8),
              // Horizontal Generated Reports List
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: generatedReportsList.length,
                  itemBuilder: (context, index) {
                    var item = generatedReportsList[index];
                    return Container(
                      height: 160,  // increased height
                      width: 150,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                item["icon"]!,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                              Spacer(),
                              Image.asset(
                                item["download"]!,
                                height: 20,
                                width: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Single title text
                          SizedBox(
                            width: 90,
                            child: Expanded(
                              child: Text(
                                item["title"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
