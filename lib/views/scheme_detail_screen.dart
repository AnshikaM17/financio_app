import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/government_scheme_model.dart';

class SchemeDetailScreen extends StatelessWidget {
  final GovernmentScheme scheme;
  final String language;
  final Future<void> Function(String, String) onSpeak;

  const SchemeDetailScreen({
    super.key,
    required this.scheme,
    required this.language,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF16A34A),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                language == 'hi' ? scheme.nameHi : scheme.nameEn,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.account_balance,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  onSpeak(
                    language == 'hi' ? scheme.nameHi : scheme.nameEn,
                    language,
                  );
                },
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Eligible Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF16A34A),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          language == 'hi'
                              ? '✅ आप इस योजना के लिए पात्र हैं'
                              : '✅ You\'re Eligible for this Scheme',
                          style: const TextStyle(
                            color: Color(0xFF16A34A),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // About Section
                  _buildSection(
                    context,
                    language == 'hi' ? 'योजना के बारे में' : 'About the Scheme',
                    Icons.info_outline,
                    language == 'hi' ? scheme.aboutHi : scheme.aboutEn,
                  ),

                  const SizedBox(height: 24),

                  // Benefits Section
                  _buildListSection(
                    context,
                    language == 'hi' ? 'लाभ' : 'Benefits',
                    Icons.star_outline,
                    language == 'hi' ? scheme.benefitsHi : scheme.benefitsEn,
                  ),

                  const SizedBox(height: 24),

                  // Documents Required Section
                  _buildListSection(
                    context,
                    language == 'hi' ? 'आवश्यक दस्तावेज़' : 'Documents Required',
                    Icons.description_outlined,
                    language == 'hi' ? scheme.documentsHi : scheme.documentsEn,
                  ),

                  const SizedBox(height: 24),

                  // How to Apply Section
                  _buildApplySection(context),

                  const SizedBox(height: 32),

                  // Official Website Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(scheme.officialWebsite),
                      icon: const Icon(Icons.open_in_new),
                      label: Text(
                        language == 'hi'
                            ? 'आधिकारिक वेबसाइट पर जाएं'
                            : 'Visit Official Website',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF16A34A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Website URL
                  Center(
                    child: Text(
                      scheme.officialWebsite,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    String content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.green.shade700, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.volume_up, size: 20),
              onPressed: () => onSpeak('$title. $content', language),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListSection(
    BuildContext context,
    String title,
    IconData icon,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.green.shade700, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.volume_up, size: 20),
              onPressed: () => onSpeak('$title. ${items.join('. ')}', language),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key < items.length - 1 ? 12 : 0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildApplySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.how_to_reg, color: Colors.green.shade700, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                language == 'hi' ? 'आवेदन कैसे करें' : 'How to Apply',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Offline Application
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.store, color: Colors.blue.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      language == 'hi' ? 'ऑफ़लाइन आवेदन' : 'Offline Application',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, size: 18),
                    onPressed: () => onSpeak(
                      '${language == 'hi' ? 'ऑफ़लाइन आवेदन' : 'Offline Application'}. ${language == 'hi' ? scheme.howToApplyOfflineHi : scheme.howToApplyOfflineEn}',
                      language,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                language == 'hi'
                    ? scheme.howToApplyOfflineHi
                    : scheme.howToApplyOfflineEn,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Online Application
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.computer, color: Colors.purple.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      language == 'hi' ? 'ऑनलाइन आवेदन' : 'Online Application',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, size: 18),
                    onPressed: () => onSpeak(
                      '${language == 'hi' ? 'ऑनलाइन आवेदन' : 'Online Application'}. ${language == 'hi' ? scheme.howToApplyOnlineHi : scheme.howToApplyOnlineEn}',
                      language,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                language == 'hi'
                    ? scheme.howToApplyOnlineHi
                    : scheme.howToApplyOnlineEn,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
