import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import '../models/activity_type.dart';
import '../models/weather_request.dart';
import '../services/app_state.dart';
import 'activity_selector.dart';
import 'status_bar.dart';

class WeatherForm extends StatefulWidget {
  const WeatherForm({super.key});

  @override
  State<WeatherForm> createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController(text: 'New York, NY');
  
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 14, minute: 0);
  ActivityType _selectedActivity = ActivityType.travel;
  
  String? _statusMessage;
  bool _isError = false;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _requestLocation() async {
    try {
      final permission = await Permission.location.request();
      if (permission != PermissionStatus.granted) {
        _showStatus('Location permission denied. Please enter location manually.', true);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final locationText = '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';
      _locationController.text = locationText;
      _showStatus('Location updated successfully!', false);
    } catch (e) {
      _showStatus('Unable to get your location. Please enter manually.', true);
    }
  }

  void _showStatus(String message, bool isError) {
    setState(() {
      _statusMessage = message;
      _isError = isError;
    });

    // Auto-hide status after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _statusMessage = null;
        });
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _onActivitySelected(ActivityType activity) {
    setState(() {
      _selectedActivity = activity;
    });
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedActivity != ActivityType.travel) {
      _showStatus('Only Travel activity is currently available.', true);
      return;
    }

    final request = WeatherRequest(
      location: _locationController.text,
      date: DateFormat('yyyy-MM-dd').format(_selectedDate),
      time: '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
      activity: _selectedActivity,
    );

    context.read<AppState>().getWeatherForecast(request);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Plan Your Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),

              // Status Message
              if (_statusMessage != null)
                StatusBar(
                  message: _statusMessage!,
                  isError: _isError,
                ),

              // Location Input
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue),
                  const SizedBox(width: 8),
                  const Text(
                    'Location',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        hintText: 'Enter city name or coordinates',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Location is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _requestLocation,
                    icon: const Icon(Icons.my_location),
                    tooltip: 'Use current location',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Date and Time
              Row(
                children: [
                  // Date Selection
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Date',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: _selectDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Time Selection
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Time',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: _selectTime,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_selectedTime.format(context)),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Activity Selector
              const Row(
                children: [
                  Icon(Icons.directions_run, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Activity Type',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ActivitySelector(
                selectedActivity: _selectedActivity,
                onActivitySelected: _onActivitySelected,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _onSubmit,
                  icon: const Icon(Icons.search),
                  label: const Text('Check Weather Comfort'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}