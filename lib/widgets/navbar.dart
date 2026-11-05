import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_config.dart';
import '../theme.dart';

// Top navigation — same on every page. Responsive:
// Desktop: full links. Mobile: hamburger menu.

class FlutteryNavBar extends StatelessWidget implements PreferredSizeWidget {
  const FlutteryNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 760;
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: FlutteryTheme.grey200)),
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.go('/'),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  AppConfig.logoPath,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: FlutteryTheme.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                        child: Text('F',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18))),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text('Fluttery',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            ]),
          ),
          const Spacer(),
          if (!isMobile) ...[
            _link(context, 'Home', '/'),
            _link(context, 'Topics', '/topics'),
            _link(context, 'Projects', '/projects'),
            _link(context, 'About', '/about'),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () => context.go('/topics'),
              child: const Text('Start learning'),
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _showMobileMenu(context),
            ),
        ],
      ),
    );
  }

  Widget _link(BuildContext context, String label, String route) {
    final active = GoRouterState.of(context).uri.toString() == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: () => context.go(route),
        child: Text(label,
            style: TextStyle(
              color: active ? FlutteryTheme.black : FlutteryTheme.grey700,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            )),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _menuItem(context, 'Home', '/'),
          _menuItem(context, 'Topics', '/topics'),
          _menuItem(context, 'Projects', '/projects'),
          _menuItem(context, 'About', '/about'),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () { Navigator.pop(context); context.go('/topics'); },
              child: const Text('Start learning')),
        ]),
      ),
    );
  }

  Widget _menuItem(BuildContext context, String label, String route) => ListTile(
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        onTap: () { Navigator.pop(context); context.go(route); },
      );
}

// Shared page shell: navbar + centred content (max 1100px) + footer.
class PageShell extends StatelessWidget {
  final Widget child;
  const PageShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const FlutteryNavBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width < 760 ? 16 : 32, vertical: 24),
                child: child,
              ),
            ),
          ),
          const _Footer(),
        ]),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: FlutteryTheme.grey200))),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: LayoutBuilder(builder: (context, c) {
            final isMobile = c.maxWidth < 600;
            final brandHeader = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    AppConfig.logoPath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Fluttery',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 18)),
              ],
            );
            return isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      brandHeader,
                      const SizedBox(height: 6),
                      const Text('Learn Flutter, one video at a time.',
                          style: TextStyle(color: FlutteryTheme.grey700)),
                      const SizedBox(height: 16),
                      const Text('© 2026 Fluttery  •  Made for learners',
                          style: TextStyle(color: FlutteryTheme.grey500)),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            brandHeader,
                            const SizedBox(height: 6),
                            const Text('Learn Flutter, one video at a time.',
                                style: TextStyle(color: FlutteryTheme.grey700)),
                          ]),
                      const Text('© 2026 Fluttery  •  Made for learners',
                          style: TextStyle(color: FlutteryTheme.grey500)),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
