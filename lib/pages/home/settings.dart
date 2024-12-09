import 'package:flutter/material.dart';

class Settings extends StatefulWidget{
    const Settings({super.key});

    @override
    State<StatefulWidget> createState() => __SettingsState();
}

class __SettingsState extends State<Settings>{
    

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;


        return CustomScrollView(slivers: [
          
        ],);
        
        /*Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding:  const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        const Icon(Icons.settings_outlined, size: 28),
                        const SizedBox(width: 10,),
                        Text("Settings", style: TextStyle(color: theme.onSurface, fontSize: 20),),
                    ],
                ),
            ),
            Expanded(child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("General", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: theme.surfaceContainer, borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Padding(padding: const EdgeInsets.all(10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text("Theme", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w500),),
                              Row(children: [
                                  Radio<String>(value: "auto", groupValue:  __settingsNotifier.themeMode,
                                      onChanged: (String? value) { __settingsNotifier.setThemeMode(value!); },
                                  ),
                                  const Text('Auto')
                              ]),
                              Row(children: [
                                  Radio<String>(value: "light", groupValue:  __settingsNotifier.themeMode,
                                      onChanged: (String? value) { __settingsNotifier.setThemeMode(value!); },),
                                  const Text("Light Mode"),
                              ]),
                              Row(children: [
                                  Radio<String>(value: "dark", groupValue:  __settingsNotifier.themeMode,
                                      onChanged: (String? value) { __settingsNotifier.setThemeMode(value!); },),
                                  const Text('Dark Mode'),
                              ])
                          ],),
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("About", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding:  const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: theme.tertiaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Padding(padding: const EdgeInsets.all(8),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text("Bsoft Weather is developed and maintained by Nobel owned by Bsoft", style: TextStyle(fontSize: 16, letterSpacing: 1.4, fontWeight: FontWeight.w300, color: theme.onTertiaryContainer),),
                              const SizedBox(height: 10),
                              Text("Weather data source: OpenWeatherman API", style: TextStyle(fontWeight: FontWeight.w500, color: theme.onTertiaryContainer),),
                          ])
                      )
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("Version", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 6, left: 20),
                  child: Text("1.0.0", style: TextStyle(color: Colors.grey, fontSize: 14, letterSpacing: 1.4, fontWeight: FontWeight.w300)),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("Privacy Policy", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("Terms and Condition", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                ),
                const SizedBox(height: 12,)
            ]),))
        ],);*/
    }
}