import 'package:flutter/material.dart';
import 'package:webmyapp/Home/MyHomePage.dart';
import 'package:webmyapp/Home/ReportCenterScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  int selectedIndex = 0;
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
      "download": "assets/homeIcons/Download Minimalistic.png",
    },
  ];

  void _onScroll() {
    // Assuming each item width + margin = 150 + 12 = 162
    double itemWidth = 162;
    double offset = _scrollController.offset;

    int newIndex = (offset / itemWidth).round();

    if (newIndex != _currentIndex &&
        newIndex >= 0 &&
        newIndex < generatedReportsList.length) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reports Center",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2A061E),
              Color(0xFF3B0724).withOpacity(0.4), // Deep Dark Plum
              Color(0xFFFFA800).withOpacity(0.2),
              Color(0x573A0400), // Very Dark Brownish Yellow
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
              SizedBox(
                child: ListView.builder(
                  itemCount: reportsList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = reportsList[index];
                    bool isSelected = index == selectedIndex;

                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.transparent,
                              width: isSelected ? 1.5 : 0.5,
                            ),
                            color:  Colors.black26,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"]!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  item["subtitle"]!,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

                SizedBox(height: 05),
                Divider(thickness: 0.8, color: Colors.grey),
                SizedBox(height: 05),
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
                        height: 160,
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
                                const Spacer(),
                                Image.asset(
                                  item["download"]!,
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              item["title"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(generatedReportsList.length, _buildDot),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = index == _currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.orange,
          width: 2,
          style:
          BorderStyle
              .solid, // For dotted effect, we will add custom painter below
        ),
      ),
      child: CustomPaint(
        painter: isActive ? null : DottedBorderPainter(color: Colors.orange),
      ),
    );
  }
}

// Custom painter for dotted border effect
class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double dotRadius;
  final double space;

  DottedBorderPainter({
    this.color = Colors.orange,
    this.dotRadius = 2,
    this.space = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
    Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawCircle(
        Offset(startX + dotRadius, size.height / 2),
        dotRadius,
        paint,
      );
      startX += dotRadius * 2 + space;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



