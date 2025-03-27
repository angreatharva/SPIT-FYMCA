import 'package:flutter/material.dart';


class FacultyInformation extends StatefulWidget {
  @override
  State<FacultyInformation> createState() => _FacultyInformationState();
}

class _FacultyInformationState extends State<FacultyInformation> {
  final List<Map<String, String>> facultyList = [
    {
      'name': 'Prof. Dr. Dhananjay Kalbande',
      'position': 'Head Of Department',
      'image': 'assets/images/dhananjay.jpg',
      'linkedinUrl': 'https://www.linkedin.com/in/dhananjay-kalbande-77349923',
      "header":"Professor S.P.I.T. | Founder AiM4u | AutoBuddys | Ai4Climate | Ex-Skinzy | TechForSocial.com",
      'education': 'Tata Institute of Social Sciences | Post-Doctorate Fellowship(PDF),Senior Research Fellow(SRF)\n'
          'Mumbai University Mumbai | PhD, Technology\n'
          'Priyadarshini College of Engineering College, Nagpur | B.E. (Computer), Computer Engineering\n'
          'Vivekanand Education Society Institute Of Technology | M.E. [ Information Technology], Information Technology',
    },
    {
      'name': 'Prof. Dr. Aarti Karande',
      'position': 'Assistant Professor',
      'image': 'assets/images/aarti_mam.png',
      'linkedinUrl': 'https://www.linkedin.com/in/aartimkarande/',
      "header":"PH.D (Comp), M.Tech, B.E | Assistant Professor@S.P.I.T. | Enterprise SA, CA, SME in DS",
      'education': 'Bhartiya Vidya Bhavans Sardar Patel Institute of Technology Munshi Nagar Andheri Mumbai | Doctor of Philosophy - PH.D , Computer Engineering\n'
          'Veermata Jijabai Technological Institute (VJTI) | M.Tech (Computer), Computer Engineering\n'
          'Shah And Anchor Kutchhi Engineering College | Bachelor of Engineering (B.Eng.), Computer Engineering\n'
          'CDAC Mumbai | Post Doctral Research Internship ',

    },
    {
      'name': 'Prof. Harshil Kanakia',
      'position': 'Assistant Professor',
      'image': 'assets/images/harshil_sir.png',
      'linkedinUrl': 'https://www.linkedin.com/in/harshil-kanakia-b477246a/',
      "header":"Certified Data Generalist | Certified DevOps Engineer | Assistant Professor at Computer Science and Engineering Department at Sardar Patel Institute of Technology",
      'education': 'Bhartiya Vidya Bhavans Sardar Patel Institute of Technology Munshi Nagar Andheri Mumbai | Doctor of Philosophy - PhD, Computer EngineeringDoctor of Philosophy - PhD, Computer Engineering\n'
          'International Institute of Information Technology Bangalore | PG in Data Science\n'
          'Bhartiya Vidya Bhavans Sardar Patel Institute of Technology Munshi Nagar Andheri Mumbai | Masters degree, Computer Engineering\n'
          'Bhartiya Vidya Bhavans Sardar Patel Institute of Technology Munshi Nagar Andheri Mumbai | Bachelors degree, Computer Engineering',

    },
    {
      'name': 'Prof. Nikhita Mangaonkar',
      'position': 'Assistant Professor',
      'image': 'assets/images/nikhita_mam.jpg',
      'linkedinUrl': 'https://www.linkedin.com/in/nikhita-mangaonkar-5268b4191/',
      "header":"Assistant Professor at Sardar Patel Institute of Technology, M.C.A",
      'education': 'Shreemati Nathibai Damodar Thackersey Womens University | Bachelor of Computer Applications\n'
          'University of Mumbai | Masters of Computer Applications, Computer Programming, Specific Applications\n'

    },
    {
      'name': 'Prof. Sakina Shaikh',
      'position': 'Assistant Professor',
      'image': 'assets/images/sakina_mam.png',
      'linkedinUrl': 'https://www.linkedin.com/in/sakina-salmani-1283a1a2/',
      "header":"Assistant Professor at Sardar Patel Institute of Technology",
      'education': 'Dwarkadas J. Sanghvi College of Engineering | Master of Technology - MTech, Computer Engineering\n'
          'Bhartiya Vidya Bhavans Sardar Patel Institute of Technology Munshi Nagar Andheri Mumbai | Doctor of Philosophy - PhD, Computer Engineering\n'
          'Rizvi College of Engineering\n'
    },
    {
      'name': 'Prof. Pallavi Thakur',
      'position': 'Assistant Professor',
      'image': 'assets/images/pallavi_mam.png',
      'linkedinUrl': 'https://www.linkedin.com/in/pallavi-thakur-8a7a271ba/',
      "header":"Assistant Professor at Bhartiya Vidya Bhavans Sardar Patel Institute of Technology Munshi Nagar Andheri Mumbai",
      'education': ""
    },
  ];
  // List to track expansion state
  late List<bool> isExpandedList;

  @override
  void initState() {
    super.initState();
    isExpandedList = List.generate(facultyList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: facultyList.length,
        itemBuilder: (context, index) {
          return _buildFacultyCard(index);
        },
      ),
    );
  }

  Widget _buildFacultyCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // Faculty Info Row
          Row(
            children: [
              _buildImage(facultyList[index]['image'] ?? ''),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      facultyList[index]['name'] ?? 'Name',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      facultyList[index]['position'] ?? 'Position',
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey[700]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpandedList[index] = !isExpandedList[index];
                  });
                },
                child: Icon(
                  isExpandedList[index] ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                ),
              ),
            ],
          ),

          // Expanded Details
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            firstChild: Container(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  facultyList[index]['header']! ?? '',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  facultyList[index]['education'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            crossFadeState: isExpandedList[index] ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 60,
            height: 60,
            color: Colors.grey[300],
            child: const Icon(Icons.error, color: Colors.red),
          );
        },
      ),
    );
  }

}