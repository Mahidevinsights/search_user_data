import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:girman_search_app/screens/web_view_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  void _launchMailClient(String targetEmail) async {
    String mailUrl = 'mailto:$targetEmail';
    try {
      await launchUrlString(mailUrl);
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: targetEmail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      flexibleSpace: Container(
          decoration: const BoxDecoration(
        color: Colors.white, // AppBar's background color
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000), // Shadow color as per requirement
            offset: Offset(0, 1.41), // Slight vertical offset
            blurRadius: 8.43, // Blur effect
          ),
        ],
      )),
      title: Image.asset('assets/images/girman_header_logo.png', height: 30),
      actions: [
        PopupMenuButton<String>(
          color: Colors.white,
          position: PopupMenuPosition.under,
          icon: const Icon(Icons.menu, color: Colors.black), // Hamburger icon
          onSelected: (value) {
            switch (value) {
              case 'Search':
                // Implement search logic if needed
                break;
              case 'Website':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InAppWebViewScreen(
                      url: 'https://www.girmantech.com/',
                      title: 'Girman Technologies',
                    ),
                  ),
                );
                break;
              case 'LinkedIn':
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InAppWebViewScreen(
                      url: 'https://www.linkedin.com/company/girmantech/',
                      title: 'GirmanTech - LinkedIn',
                    ),
                  ),
                );
                break;
              case 'Contact':
                _launchMailClient("contact@girmantech.com");
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Search',
              child: Text(
                'SEARCH',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Website',
              child: Text(
                'WEBSITE',
              ),
            ),
            const PopupMenuItem<String>(
              value: 'LinkedIn',
              child: Text('LINKEDIN'),
            ),
            const PopupMenuItem<String>(
              value: 'Contact',
              child: Text('CONTACT'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
