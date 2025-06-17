import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.white,
          background: Colors.black,
          surface: Colors.white10,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.white70),
        ),
        cardColor: Colors.white10,
        dividerColor: Colors.white24,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            textStyle: MaterialStatePropertyAll(TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
            elevation: MaterialStatePropertyAll(0),
          ),
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int score = 0;
  int clickPower = 1;
  int autoClickers = 0;
  int autoClickerCost = 50;
  int clickPowerCost = 30;
  int totalClicks = 0;
  Timer? autoClickerTimer;

  final List<String> statsLabels = [
    'Total de Cliques',
    'Poder do Clique',
    'Autoclickers',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoClicker();
  }

  void _startAutoClicker() {
    autoClickerTimer?.cancel();
    if (autoClickers > 0) {
      autoClickerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          score += autoClickers;
        });
      });
    }
  }

  void _incrementScore() {
    setState(() {
      score += clickPower;
      totalClicks++;
    });
  }

  void _buyAutoClicker() {
    if (score >= autoClickerCost) {
      setState(() {
        score -= autoClickerCost;
        autoClickers++;
        autoClickerCost = (autoClickerCost * 1.5).toInt();
        _startAutoClicker();
      });
    }
  }

  void _buyClickPower() {
    if (score >= clickPowerCost) {
      setState(() {
        score -= clickPowerCost;
        clickPower++;
        clickPowerCost = (clickPowerCost * 1.7).toInt();
      });
    }
  }

  List<Widget> get _screens => [
    GameScreen(
      score: score,
      onClick: _incrementScore,
      clickPower: clickPower,
    ),
    UpgradesScreen(
      score: score,
      autoClickers: autoClickers,
      autoClickerCost: autoClickerCost,
      clickPower: clickPower,
      clickPowerCost: clickPowerCost,
      onBuyAutoClicker: _buyAutoClicker,
      onBuyClickPower: _buyClickPower,
    ),
    StatsScreen(
      totalClicks: totalClicks,
      clickPower: clickPower,
      autoClickers: autoClickers,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    autoClickerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.games),
              label: 'Jogo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upgrade),
              label: 'Upgrades',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Estatísticas',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          backgroundColor: Colors.black,
          onTap: _onItemTapped,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int score;
  final int clickPower;
  final VoidCallback onClick;
  const GameScreen({super.key, required this.score, required this.onClick, required this.clickPower});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _onTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    widget.onClick();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clicker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 0,
              color: Colors.white10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  children: [
                    const Text(
                      'PONTOS',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white70, letterSpacing: 2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.score}',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _onTap,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 - _controller.value,
                    child: child,
                  );
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10,
                        blurRadius: 32,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.mouse_outlined,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpgradesScreen extends StatelessWidget {
  final int score;
  final int autoClickers;
  final int autoClickerCost;
  final int clickPower;
  final int clickPowerCost;
  final VoidCallback onBuyAutoClicker;
  final VoidCallback onBuyClickPower;
  const UpgradesScreen({super.key, required this.score, required this.autoClickers, required this.autoClickerCost, required this.clickPower, required this.clickPowerCost, required this.onBuyAutoClicker, required this.onBuyClickPower});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrades'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UpgradeTile(
                title: 'Autoclicker',
                description: 'Ganha +1 ponto por segundo automaticamente.',
                cost: autoClickerCost,
                owned: autoClickers,
                enabled: score >= autoClickerCost,
                onBuy: onBuyAutoClicker,
                icon: Icons.flash_on,
              ),
              const SizedBox(height: 24),
              UpgradeTile(
                title: 'Poder do Clique',
                description: 'Cada clique vale +1 ponto extra.',
                cost: clickPowerCost,
                owned: clickPower,
                enabled: score >= clickPowerCost,
                onBuy: onBuyClickPower,
                icon: Icons.touch_app,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpgradeTile extends StatelessWidget {
  final String title;
  final String description;
  final int cost;
  final int owned;
  final bool enabled;
  final VoidCallback onBuy;
  final IconData icon;
  const UpgradeTile({super.key, required this.title, required this.description, required this.cost, required this.owned, required this.enabled, required this.onBuy, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white24,
              ),
              padding: const EdgeInsets.all(14),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(description, style: const TextStyle(fontSize: 16, color: Colors.white70)),
                  const SizedBox(height: 6),
                  Text('Possuídos: $owned', style: const TextStyle(fontSize: 14, color: Colors.white54)),
                ],
              ),
            ),
            Column(
              children: [
                Text('Custo: $cost', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: enabled ? onBuy : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: enabled ? Colors.white : Colors.white24,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Text('Comprar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatsScreen extends StatelessWidget {
  final int totalClicks;
  final int clickPower;
  final int autoClickers;
  const StatsScreen({super.key, required this.totalClicks, required this.clickPower, required this.autoClickers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Card(
            elevation: 0,
            color: Colors.white10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ESTATÍSTICAS',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 2),
                  ),
                  const SizedBox(height: 20),
                  Text('Total de Cliques: $totalClicks', style: const TextStyle(fontSize: 18, color: Colors.white)),
                  Text('Poder do Clique: $clickPower', style: const TextStyle(fontSize: 18, color: Colors.white)),
                  Text('Autoclickers: $autoClickers', style: const TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
