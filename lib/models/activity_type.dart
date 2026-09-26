enum ActivityType {
  travel,
  fishing,
  wedding,
  sports,
  hiking,
  picnic;

  String get displayName {
    switch (this) {
      case ActivityType.travel:
        return 'Travel';
      case ActivityType.fishing:
        return 'Fishing';
      case ActivityType.wedding:
        return 'Wedding';
      case ActivityType.sports:
        return 'Sports';
      case ActivityType.hiking:
        return 'Hiking';
      case ActivityType.picnic:
        return 'Picnic';
    }
  }

  bool get isEnabled {
    return this == ActivityType.travel; // Only travel is enabled
  }
}