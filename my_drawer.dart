
import 'package:flutter/material.dart';
import 'package:music_player/auth_provider.dart';
import 'package:music_player/pages/settings_page.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.15),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? Icon(
                      Icons.person,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    )
                        : null,
                  ),
                  const SizedBox(height: 8),
                  if (user != null) ...[
                    Text(
                      user.displayName ?? 'User',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text(
                "HOME",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: const Text(
                "SETTINGS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const SettingsPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
            if (user == null)
              ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.login,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: const Text(
                  "SIGN IN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                onTap: () => authProvider.signInWithGoogle(),
              )
            else
              ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: const Text(
                  "SIGN OUT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                onTap: () => authProvider.signOut(),
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "Surdhoni v1.0",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}