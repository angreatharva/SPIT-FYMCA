import 'package:flutter/material.dart';

class VisionAndMission extends StatefulWidget {
  const VisionAndMission({super.key});

  @override
  State<VisionAndMission> createState() => _VisionAndMissionState();
}

class _VisionAndMissionState extends State<VisionAndMission> {
  final List<Map<String, String>> sections = [
    {
      "title": "DEPARTMENT VISION\n(Effective from 2024-25)",
      "content":
      "To develop globally competent and ethical professionals in Computer Science and Engineering and enable them to contribute to society."
    },
    {
      "title": "DEPARTMENT VISION",
      "content":
      "To create a center of excellence which will produce cutting-edge technologies to cater needs of Business and Society."
    },
    {
      "title": "DEPARTMENT MISSION\n(Effective from 2024-25)",
      "content":
      "M1: To provide rigorous, high-standard, multidisciplinary curriculum and innovative T-L-E-A processes and ensure a stimulating academic environment.\n\n"
          "M2: To promote research and innovations through collaborations.\n\n"
          "M3: To develop requisite attitudes and skills, besides providing a strong knowledge foundation.\n\n"
          "M4: To foster ethics and social responsibility among stakeholders and imbibe a sense of contribution."
    },
    {
      "title": "DEPARTMENT MISSION",
      "content":
      "1. To provide high quality education.\n\n"
          "2. To train the students to excel in cutting-edge technologies that makes them industry ready.\n\n"
          "3. To inculcate ethical and professional values in students for betterment of society.\n\n"
          "4. To inculcate Entrepreneurial mindset in students to make them job creators."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(sections.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
                color: Colors.amber.shade300,
              ),
              child: ExpansionTile(
                title: Text(
                  sections[index]["title"]!,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      sections[index]["content"]!,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
