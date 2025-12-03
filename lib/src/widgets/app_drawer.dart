// lib/src/widgets/app_drawer.dart
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String role;
  const AppDrawer({required this.role});
  @override
  Widget build(BuildContext ctx) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('User Name'),
              accountEmail: Text('user@example.com'),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
              decoration: BoxDecoration(color: Theme.of(ctx).primaryColor),
            ),
            if (role == 'admin')
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text('Add Teacher'),
                onTap: () => Navigator.pushNamed(ctx, '/admin/add-teacher'),
              ),
            if (role == 'teacher')
              ListTile(
                leading: Icon(Icons.school),
                title: Text('Take Attendance'),
                onTap: () =>
                    Navigator.pushNamed(ctx, '/teacher/take-attendance'),
              ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () => Navigator.pushNamed(ctx, '/notifications'),
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => Navigator.pushNamed(ctx, '/login'),
            ),
          ],
        ),
      ),
    );
  }
}
