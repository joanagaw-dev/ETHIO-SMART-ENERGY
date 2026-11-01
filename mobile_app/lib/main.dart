import 'package:flutter/material.dart';
import 'package:ethio_smart_energy/l10n/app_localizations.dart';

void main() {
  runApp(const EthioSmartEnergyApp());
}

const Color brandGreen = Color(0xFF087F5B);
const Color lightGreen = Color(0xFFE5F5EF);

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
          seedColor: brandGreen,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9F8),
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

class HomeDashboard extends StatefulWidget {
  final Function(String) onLanguageChanged;

  const HomeDashboard({
    super.key,
    required this.onLanguageChanged,
  });

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int selectedIndex = 0;

  void showService(String title, IconData icon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(icon, color: brandGreen, size: 40),
        title: Text(title),
        content: const Text(
          'This service is currently in DEMO mode. '
          'EEU connection is not available yet.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final pages = [
      buildHome(t),
      buildBills(t),
      buildReports(t),
      buildProfile(t),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: brandGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'ETHIO SMART ENERGY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: widget.onLanguageChanged,
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
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: lightGreen,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt_long_outlined),
            selectedIcon: const Icon(Icons.receipt_long),
            label: t.bills,
          ),
          NavigationDestination(
            icon: const Icon(Icons.report_outlined),
            selectedIcon: const Icon(Icons.report),
            label: t.reports,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: t.profile,
          ),
        ],
      ),
    );
  }

  Widget buildHome(AppLocalizations t) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.welcome,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(t.tagline),
          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: brandGreen,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.prepaidBalance,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ETB 1,250.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'DEMO ACCOUNT',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: infoCard(
                  t.monthlyUsage,
                  '145 kWh',
                  Icons.electric_bolt,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: infoCard(
                  t.estimatedBill,
                  'ETB 580',
                  Icons.receipt_long,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          sectionTitle(t.quickServices),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: [
              serviceCard(
                t.reportOutage,
                Icons.power_off,
              ),
              serviceCard(
                t.voltageProblem,
                Icons.electrical_services,
              ),
              serviceCard(
                t.payElectricity,
                Icons.payment,
              ),
              serviceCard(
                t.aiAssistant,
                Icons.smart_toy,
              ),
              serviceCard(
                'Energy Monitoring',
                Icons.monitor_heart,
              ),
              serviceCard(
                'Service Tracking',
                Icons.track_changes,
              ),
            ],
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.insights,
                color: brandGreen,
                size: 35,
              ),
              title: Text(t.smartEnergyMonitoring),
              subtitle: const Text(
                'Smart Meter • IoT • Energy Analytics',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => showService(
                'Smart Energy Monitoring',
                Icons.monitor_heart,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Text(
              t.demoDisclaimer,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBills(AppLocalizations t) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        sectionTitle('Electricity Bills'),
        const SizedBox(height: 12),
        infoCard('Current Balance', 'ETB 1,250.00',
            Icons.account_balance_wallet),
        const SizedBox(height: 12),
        billCard('October 2026', 'ETB 580.00', 'Demo'),
        billCard('September 2026', 'ETB 520.00', 'Demo'),
        billCard('August 2026', 'ETB 610.00', 'Demo'),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () => showService(
            'Electricity Payment',
            Icons.payment,
          ),
          icon: const Icon(Icons.payment),
          label: const Text('Pay Electricity (Demo)'),
          style: ElevatedButton.styleFrom(
            backgroundColor: brandGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
          ),
        ),
      ],
    );
  }

  Widget buildReports(AppLocalizations t) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        sectionTitle('Customer Reports'),
        const SizedBox(height: 12),
        reportCard(
          'Power Outage',
          Icons.power_off,
        ),
        reportCard(
          'Low Voltage',
          Icons.bolt,
        ),
        reportCard(
          'High Voltage',
          Icons.electrical_services,
        ),
        reportCard(
          'Meter Problem',
          Icons.speed,
        ),
        reportCard(
          'Other Electricity Problem',
          Icons.report_problem,
        ),
      ],
    );
  }

  Widget buildProfile(AppLocalizations t) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundColor: lightGreen,
          child: Icon(
            Icons.person,
            size: 50,
            color: brandGreen,
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'Demo Customer',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Center(child: Text('Customer Account: DEMO-001')),
        const SizedBox(height: 25),
        profileItem(Icons.person, 'Personal Information'),
        profileItem(Icons.electric_meter, 'Electricity Account'),
        profileItem(Icons.notifications, 'Notifications'),
        profileItem(Icons.language, 'Language Settings'),
        profileItem(Icons.support_agent, 'Customer Support'),
        profileItem(Icons.info_outline, 'About ETHIO SMART ENERGY'),
      ],
    );
  }

  Widget infoCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Icon(icon, color: brandGreen, size: 28),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center),
            const SizedBox(height: 7),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: brandGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceCard(String title, IconData icon) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => showService(title, icon),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 34, color: brandGreen),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget billCard(String month, String amount, String status) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.receipt_long,
          color: brandGreen,
        ),
        title: Text(month),
        subtitle: Text('Status: $status'),
        trailing: Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: brandGreen,
          ),
        ),
      ),
    );
  }

  Widget reportCard(String title, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: brandGreen),
        title: Text(title),
        subtitle: const Text('Submit a demo service report'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => showService(title, icon),
      ),
    );
  }

  Widget profileItem(IconData icon, String title) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: brandGreen),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => showService(title, icon),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}