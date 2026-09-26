import 'package:flutter/material.dart';
import '../models/activity_type.dart';

class ActivitySelector extends StatelessWidget {
  final ActivityType selectedActivity;
  final Function(ActivityType) onActivitySelected;

  const ActivitySelector({
    super.key,
    required this.selectedActivity,
    required this.onActivitySelected,
  });

  IconData _getActivityIcon(ActivityType activity) {
    switch (activity) {
      case ActivityType.travel:
        return Icons.flight;
      case ActivityType.fishing:
        return Icons.phishing;
      case ActivityType.wedding:
        return Icons.favorite;
      case ActivityType.sports:
        return Icons.sports_volleyball;
      case ActivityType.hiking:
        return Icons.terrain;
      case ActivityType.picnic:
        return Icons.nature_people;
    }
  }

  void _showComingSoonMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This activity is not yet available.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: ActivityType.values.map((activity) {
        final isSelected = activity == selectedActivity;
        final isEnabled = activity.isEnabled;

        return GestureDetector(
          onTap: () {
            if (isEnabled) {
              onActivitySelected(activity);
            } else {
              _showComingSoonMessage(context);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected && isEnabled
                  ? Theme.of(context).primaryColor
                  : isEnabled
                  ? Colors.grey[100]
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected && isEnabled
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getActivityIcon(activity),
                  color: isSelected && isEnabled
                      ? Colors.white
                      : isEnabled
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                  size: 28,
                ),
                const SizedBox(height: 4),
                Text(
                  activity.displayName,
                  style: TextStyle(
                    color: isSelected && isEnabled
                        ? Colors.white
                        : isEnabled
                        ? Colors.black87
                        : Colors.grey[400],
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}