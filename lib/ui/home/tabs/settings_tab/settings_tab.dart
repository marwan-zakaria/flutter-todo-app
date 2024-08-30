import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:future_task_management_app/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/route_manager/routes_manager.dart';
import '../../../../providers/app_auth_provider.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider myProvider =
        Provider.of<SettingsProvider>(context); // templete of settinsProvider
    String selectedTheme = myProvider.currentTheme == ThemeMode.light
        ? AppLocalizations.of(context)!.light
        : AppLocalizations.of(context)!.dark;
    String selectedLang = myProvider.currentLang == 'en'
        ? AppLocalizations.of(context)!.english
        : AppLocalizations.of(context)!.arabic;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.theme),
          SizedBox(
            height: 8.h,
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2)),
              child: Row(
                children: [
                  Expanded(child: Text(selectedTheme)),
                  DropdownButton<String>(
                    elevation: 0,
                    // dropdownColor: Colors.red,
                    focusColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(0),
                    autofocus: false,
                    items: <String>[
                      AppLocalizations.of(context)!.light,
                      AppLocalizations.of(context)!.dark
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (item) {
                      selectedTheme = item!;
                      item == AppLocalizations.of(context)!.light
                          ? myProvider.changeThemeMode(ThemeMode.light)
                          : myProvider.changeThemeMode(ThemeMode.dark);

                      print(item);
                    },
                  )
                ],
              )),
          SizedBox(
            height: 12.h,
          ),
          Text(AppLocalizations.of(context)!.language),
          SizedBox(
            height: 8.h,
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2)),
              child: Row(
                children: [
                  Expanded(child: Text(selectedLang)),
                  DropdownButton<String>(
                    elevation: 0,
                    focusColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(0),
                    autofocus: false,
                    items: <String>[
                      AppLocalizations.of(context)!.english,
                      AppLocalizations.of(context)!.arabic
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newLang) {
                      selectedLang = newLang!;
                      newLang == AppLocalizations.of(context)!.english
                          ? myProvider.changeAppLanguage('en')
                          : myProvider.changeAppLanguage('ar');

                      print(newLang);
                    },
                  )
                ],
              )),
          Container(
            alignment: Alignment.bottomCenter,
            height: 200,// يحدد المحاذاة داخل الحاوية
            child: ElevatedButton(
              onPressed: () async{
                var appAuth = Provider.of<AppAuthProvider>(context, listen: false);
                await appAuth.logout();
                Navigator.of(context).pushReplacementNamed(RouteManger.loginRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // لون الزر
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // الحشو
                textStyle: TextStyle(fontSize: 18), // حجم النص
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // يجعل الصف يأخذ مساحة صغيرة فقط على حسب محتواه
                children: [
                  Text('Logout'),
                  SizedBox(width: 8), // مسافة بين النص والأيقونة
                  Icon(Icons.logout),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
