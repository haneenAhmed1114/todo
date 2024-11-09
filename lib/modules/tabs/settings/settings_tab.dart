import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/modules/authontication/view/login_screen.dart';
import 'package:todo_application/shared/remote/firebase_services.dart';
import 'package:todo_application/shared/reusable_components/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../shared/provider/theme_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.0,
            ),
            ListTile(
                title: Text('Log out'),
                trailing: Icon(Icons.logout),
                onTap: ()
                {
                  FirebaseServices.logout();
                  Provider.of<TaskProvider>(context,listen: false).tasks.clear();
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
              ),
            SizedBox(
              height: 20.0,
            ),
            // Language Dropdown
             Text(
              AppLocalizations.of(context)!.lang,
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
              value:provider.localCode ,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('Arabic')),
              ],
              onChanged: (value) {
                if(value!=null)
                  {
                    provider.changeAppLocal(value);
                  }
                },
            ),
            const SizedBox(height: 24.0),

            // Mode Dropdown
             Text(
               AppLocalizations.of(context)!.mode,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              ),
              value: 'Light',
              items: const [
                DropdownMenuItem(value: 'Light', child: Text('Light')),
                DropdownMenuItem(value: 'Dark', child: Text('Dark')),
              ],
              onChanged: (value) {

              },
            ),
          ],
        ),
      ),
    );
  }
}


