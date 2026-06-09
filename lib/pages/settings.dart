import 'package:bmusic/blocs/settings_bloc.dart';
import 'package:bmusic/blocs/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget{
    const Settings({super.key});

    @override
    State<StatefulWidget> createState() => __SettingsState();
}

class __SettingsState extends State<Settings>{
    

    @override
    Widget build(BuildContext context) {
        final ColorScheme theme = Theme.of(context).colorScheme;

        return Container(color: theme.surfaceContainerLowest,
          child: CustomScrollView(slivers: [
              SliverAppBar(elevation: 0,
                  title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: theme.primary),),
                  leading: Icon(Icons.settings, color: theme.primary, size: 34,),
                  leadingWidth: 30,
                  floating: true, pinned: true,
                  expandedHeight: 120,
                  flexibleSpace: const FlexibleSpaceBar( title: Text("Settings")),
              ),
              SliverList.list(children: [
                  Padding(padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text("General", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                  ),
                  BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
                      return Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: theme.surfaceContainer, borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(padding: const EdgeInsets.all(10),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text("Theme", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w500),),
                                      Row(children: [
                                          Radio<ThemeMode>(value: ThemeMode.system, groupValue: state.themeMode,
                                              onChanged: (ThemeMode? value) { context.read<SettingsCubit>().themeMode = value!; }),
                                          const Text('Auto')
                                      ]),
                                      Row(children: [
                                          Radio<ThemeMode>(value: ThemeMode.light, groupValue: state.themeMode,
                                              onChanged: (ThemeMode? value) { context.read<SettingsCubit>().themeMode = value!; }),
                                          const Text("Light Mode"),
                                      ]),
                                      Row(children: [
                                          Radio<ThemeMode>(value: ThemeMode.dark, groupValue: state.themeMode,
                                              onChanged: (ThemeMode? value) { context.read<SettingsCubit>().themeMode = value!; }),
                                          const Text('Dark Mode'),
                                      ])
                                  ]),
                              )
                          ),
                      );
                  }),
                  Padding(padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text("About", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                  ),
                  Padding(padding:  const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: DecoratedBox(decoration: BoxDecoration(color: theme.onSecondaryContainer, borderRadius: const BorderRadius.all(Radius.circular(10))),
                          child: Padding(padding: const EdgeInsets.all(8),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text("BMusic is solely developed and maintained by Nobel owned by Bsoft Limited", style: GoogleFonts.acme(fontSize: 18, fontWeight: FontWeight.w300, color: theme.onSecondary),),
                                  const SizedBox(height: 10),
                                  Text("\u24B8 2025 Bsoft Limited", style: GoogleFonts.adamina(fontWeight: FontWeight.w200, fontSize: 16, letterSpacing: 1.4, color: theme.onSecondary),),
                              ])
                          )
                      )
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text("Version", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 6, left: 20),
                      child: Text("1.0.0", style: TextStyle(color: Colors.grey, fontSize: 14, letterSpacing: 1.4, fontWeight: FontWeight.w300)),
                  ),
                  const SizedBox(height: 20,),
                  Padding(padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text("Privacy Policy", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Text("Terms and Condition", style: TextStyle(color: theme.primary, fontSize: 16, fontWeight: FontWeight.w600),),
                  )
              ])
          ]),
        );
    }
}