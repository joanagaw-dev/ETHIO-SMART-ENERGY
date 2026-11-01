
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const EthioSmartEnergyApp());
}

class EthioSmartEnergyApp extends StatefulWidget {
  const EthioSmartEnergyApp({super.key});

  @override
  State<EthioSmartEnergyApp> createState() =>
      _EthioSmartEnergyAppState();
}

class _EthioSmartEnergyAppState
    extends State<EthioSmartEnergyApp> {
  Locale selectedLocale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ETHIO SMART ENERGY',
      locale: selectedLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates:
          AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF087F5B),
        ),
      ),
      home: HomeDashboard(
        onLanguageChanged: (locale) {
          setState(() {
            selectedLocale = Locale(locale);
          });
        },
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  final Function(String) onLanguageChanged;

  const HomeDashboard({
    super.key,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF087F5B),
        foregroundColor: Colors.white,
        title: Text(t.appTitle),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: onLanguageChanged,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'am', child: Text('አማርኛ')),
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'om', child: Text('Afaan Oromo')),
              PopupMenuItem(value: 'ti', child: Text('ትግርኛ')),
              PopupMenuItem(value: 'so', child: Text('Soomaali')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.welcome,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(t.tagline),
            const SizedBox(height: 20),

            Card(
              color: const Color(0xFFE5F5EF),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.prepaidBalance),
                    const SizedBox(height: 8),
                    const Text(
                      'ETB 1,250.00',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF087F5B),
                      ),
                    ),
                    const Text('DEMO DATA'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    title: t.monthlyUsage,
                    value: '145 kWh',
                    icon: Icons.electric_bolt,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _InfoCard(
                    title: t.estimatedBill,
                    value: 'ETB 580',
                    icon: Icons.receipt_long,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              t.quickServices,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4,
              children: [
                _ServiceCard(
                  title: t.reportOutage,
                  icon: Icons.power_off,
                ),
                _ServiceCard(
                  title: t.voltageProblem,
                  icon: Icons.electrical_services,
                ),
                _ServiceCard(
                  title: t.payElectricity,
                  icon: Icons.payment,
                ),
                _ServiceCard(
                  title: t.aiAssistant,
                  icon: Icons.smart_toy,
                ),
              ],
            ),

            const SizedBox(height: 18),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.monitor_heart,
                  color: Color(0xFF087F5B),
                  size: 34,
                ),
                title: Text(t.smartEnergyMonitoring),
                subtitle: const Text(
                  'Smart Meter • IoT • Energy Analytics',
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                t.demoDisclaimer,
                style: const TextStyle(
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF087F5B),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: t.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt),
            label: t.bills,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.report),
            label: t.reports,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: t.profile,
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF087F5B)),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ServiceCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: const Color(0xFF087F5B),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}