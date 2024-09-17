import 'package:flutter/material.dart';
import 'package:routing_and_menu/participants_form_widget.dart';

class ParticipantsPage extends StatelessWidget {
  const ParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: const Center(
        child: ParticipantsFormWidget(),
      ),
    );
  }
}
