import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onDone;
  const SplashScreen({super.key, required this.onDone});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _fadeController;
  late AnimationController _dotController;

  late Animation<double> _floatAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _dotAnim;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: 0, end: -18).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _dotAnim = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(parent: _dotController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });

    Future.delayed(const Duration(seconds: 3), widget.onDone);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _fadeController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A0A2E),
              Color(0xFF2D0A4E),
              Color(0xFF4A1060),
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Stars
            ...List.generate(20, (i) {
              final x = _random.nextDouble();
              final y = _random.nextDouble();
              final size = _random.nextDouble() * 4 + 2;
              return Positioned(
                left: MediaQuery.of(context).size.width * x,
                top: MediaQuery.of(context).size.height * y,
                child: _TwinkleStar(size: size, delay: Duration(milliseconds: (_random.nextDouble() * 3000).toInt())),
              );
            }),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Floating lotus emoji
                  AnimatedBuilder(
                    animation: _floatAnim,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnim.value),
                        child: child,
                      );
                    },
                    child: const Text('🪷', style: TextStyle(fontSize: 100)),
                  ),
                  const SizedBox(height: 16),

                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Column(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [AppColors.gold, Color(0xFFFFB300)],
                          ).createShader(bounds),
                          child: const Text(
                            'MURUGAN PILGRIM',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'ARUPADAI VEEDU GUIDE',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'வேல் முருகன் துணை',
                          style: TextStyle(
                            color: Color(0xB3FFD700),
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Pulse dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return AnimatedBuilder(
                        animation: _dotController,
                        builder: (context, child) {
                          final delay = i * 0.2;
                          final value = ((_dotController.value - delay) % 1.0).abs();
                          final scale = 0.8 + value * 0.4;
                          final opacity = 0.4 + value * 0.6;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Transform.scale(
                              scale: scale,
                              child: Opacity(
                                opacity: opacity.clamp(0.0, 1.0),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.gold,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Bottom text
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Text(
                'Loading sacred journey...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0x80FFD700),
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TwinkleStar extends StatefulWidget {
  final double size;
  final Duration delay;
  const _TwinkleStar({required this.size, required this.delay});

  @override
  State<_TwinkleStar> createState() => _TwinkleStarState();
}

class _TwinkleStarState extends State<_TwinkleStar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000 + widget.delay.inMilliseconds % 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.2, end: 1.0).animate(_ctrl),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
