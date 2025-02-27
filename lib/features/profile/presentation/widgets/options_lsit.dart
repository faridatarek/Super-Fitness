import 'package:flutter/material.dart';
import 'package:super_fitness/features/profile/presentation/widgets/option_tile.dart';
import 'package:super_fitness/utils/assets_manager.dart';

List<Widget> optionsList = [
  OptionTile(svgPath: SVGAssets.person, title: "Edit Profile"),
  OptionTile(svgPath: SVGAssets.change, title: "Change Password"),
  //language
  OptionTile(svgPath: SVGAssets.security, title: "Security"),
  OptionTile(svgPath: SVGAssets.privacy, title: "Privacy Policy"),
  OptionTile(svgPath: SVGAssets.help, title: "Help"),
  OptionTile(svgPath: SVGAssets.logout, title: "Logout"),
];
