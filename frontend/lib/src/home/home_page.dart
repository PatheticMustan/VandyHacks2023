import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('home page'),
    );
  }
}



class PrescriptionDetails  {
  const PrescriptionDetails(this.name, this.dose, this.time, this.info);
  final String name;
  final String dose;
  final List<String> time;
  final String info;

}

class PrescriptionCard extends StatelessWidget {
  PrescriptionCard({super.key, 
  required this.details});

  final PrescriptionDetails details;

  final timeIcons = <String, IconData>{
    'Morning' : Icons.sunny_snowing,
    'Afternoon' : Icons.sunny,
    'Evening' : Icons.bedtime_rounded,
    'Bedtime' : Icons.airline_seat_individual_suite_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,);
    
    final doseStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontStyle: FontStyle.italic,);

    final infoStyle = theme.textTheme.bodySmall!.copyWith(
       color: theme.colorScheme.onPrimary,
      );
    
    

    return Card(
      color: theme.colorScheme.primary,
      child: Column(
        children: [

          Row(
            children: [
            Text(details.name, style: nameStyle),
            //insert right align edit here
            ],
          ),

          const SizedBox(height: 10),

          Text(details.dose, style: doseStyle),

          const SizedBox(height: 30),

          Row(
            children: [
             // icons go here
             for (String s in details.time) 
                Icon(timeIcons[s]),
            ],),

            const SizedBox(height: 10),

            const Text('Important information:'),

            const SizedBox(height: 10),

            Text(details.info, style: infoStyle),
          ],
        ),
      );
    
  }
}


