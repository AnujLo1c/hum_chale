import 'package:flutter/material.dart';
import 'package:hum_chale/models/trip.dart';

class HostedTRSelection extends StatefulWidget {
  static String routeName = "hosted-trip-request-selection";
  final Trip trip;

  const HostedTRSelection({super.key, required this.trip});

  @override
  State<HostedTRSelection> createState() => _HostedTRSelectionState();
}

class _HostedTRSelectionState extends State<HostedTRSelection> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
