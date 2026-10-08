
import 'package:flutter/material.dart';

void main() {
  runApp(const InventarisKelasApp());
}

class AppColors {
  static const primary = Color(0xFF2563EB);
  static const background = Color(0xFFF5F7FB);
  static const text = Color(0xFF172033);
  static const muted = Color(0xFF6B7280);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFDC2626);
}

class AppUser {
  final String name;
  final String role;
  final String pin;

  const AppUser({
    required this.name,
    required this.role,
    required this.pin,
  });
}

const demoUsers = [
  AppUser(name: 'Ketua', role: 'Ketua', pin: '1234'),
  AppUser(name: 'Anggota 01', role: 'Anggota', pin: '1101'),
  AppUser(name: 'Anggota 02', role: 'Anggota', pin: '1102'),
  AppUser(name: 'Anggota 03', role: 'Anggota', pin: '1103'),
  AppUser(name: 'Anggota 04', role: 'Anggota', pin: '1104'),
  AppUser(name: 'Anggota 05', role: 'Anggota', pin: '1105'),
];

class InventarisKelasApp extends StatelessWidget {
  const InventarisKelasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventaris Kelas',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int selectedUser = 0;
  final pinController = TextEditingController();
  String? error;

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  void login() {
    final user = demoUsers[selectedUser];

    if (pinController.text.trim() == user.pin) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DashboardPage(user: user),
        ),
      );
      return;
    }

    setState(() {
      error = 'PIN salah. Gunakan PIN demo yang tercantum di bawah.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Inventaris Kelas',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pemeriksaan inventaris ruangan, offline dan sederhana.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.muted,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Pilih pengguna',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: selectedUser,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    items: List.generate(
                      demoUsers.length,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text(
                          '${demoUsers[index].name} • ${demoUsers[index].role}',
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedUser = value;
                        error = null;
                        pinController.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    onSubmitted: (_) => login(),
                    decoration: const InputDecoration(
                      labelText: 'PIN',
                      counterText: '',
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                    ),
                  ),
                  if (error != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      error!,
                      style: const TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: login,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PIN demo',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Ketua 1234  •  Anggota 01–05: 1101–1105',
                          style: TextStyle(color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final AppUser user;

  const DashboardPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _WelcomeCard(user: user),
          const SizedBox(height: 18),
          const Text(
            'Ringkasan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.meeting_room_rounded,
                  value: '0',
                  label: 'Ruangan',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.inventory_2_rounded,
                  value: '0',
                  label: 'Inventaris',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.fact_check_rounded,
                  value: '0',
                  label: 'Pemeriksaan',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.warning_amber_rounded,
                  value: '0',
                  label: 'Bermasalah',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Menu cepat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          _ActionCard(
            icon: Icons.add_business_rounded,
            title: 'Tambah Ruangan',
            subtitle: 'Siapkan master gedung, lantai, dan ruangan.',
            onTap: () => _comingSoon(context, 'Master Ruangan'),
          ),
          _ActionCard(
            icon: Icons.add_box_rounded,
            title: 'Tambah Inventaris',
            subtitle: 'Catat barang dan ID inventaris.',
            onTap: () => _comingSoon(context, 'Master Inventaris'),
          ),
          _ActionCard(
            icon: Icons.fact_check_outlined,
            title: 'Pemeriksaan',
            subtitle: 'Lakukan pemeriksaan sesuai jadwal.',
            onTap: () => _comingSoon(context, 'Pemeriksaan'),
          ),
          _ActionCard(
            icon: Icons.qr_code_scanner_rounded,
            title: 'Scan QR',
            subtitle: 'Buka data inventaris melalui QR Code.',
            onTap: () => _comingSoon(context, 'Scan QR'),
          ),
          _ActionCard(
            icon: Icons.backup_rounded,
            title: 'Backup & Export',
            subtitle: 'Nantinya Excel, database, dan foto.',
            onTap: () => _comingSoon(context, 'Backup & Export'),
          ),
        ],
      ),
    );
  }

  static void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature akan kita bangun pada tahap berikutnya.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  final AppUser user;

  const _WelcomeCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2563EB),
            Color(0xFF1D4ED8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 8),
            color: Color(0x222563EB),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat datang 👋',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '${user.role} • Mode V1: semua bisa edit',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.text,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.muted,
              height: 1.3,
            ),
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
