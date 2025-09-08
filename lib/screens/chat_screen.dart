import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late GoogleMapController mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};

  final List<ChatMessage> _messages = [
    ChatMessage(
      sender: 'Operator 1',
      message: 'All units, situation normal in sector 7',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      location: const LatLng(37.4219999, -122.0840575),
    ),
    ChatMessage(
      sender: 'Rescue Team Alpha',
      message: 'Moving to coordinates 37.422, -122.084',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      location: const LatLng(37.4229999, -122.0850575),
    ),
    ChatMessage(
      sender: 'Drone Pilot 2',
      message: 'Visual contact established',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      location: const LatLng(37.4209999, -122.0830575),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _setupMarkers();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          _currentPosition = position;
        });

        if (mounted) {
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(position.latitude, position.longitude),
              15.0,
            ),
          );
        }
      }
    } catch (e) {
      // Handle location error - use default location (Google HQ)
      setState(() {
        _currentPosition = Position(
          latitude: 37.4219999,
          longitude: -122.0840575,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      });
    }
  }

  void _setupMarkers() {
    for (int i = 0; i < _messages.length; i++) {
      final message = _messages[i];
      _markers.add(
        Marker(
          markerId: MarkerId('user_$i'),
          position: message.location,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            i == 0
                ? BitmapDescriptor.hueCyan
                : i == 1
                ? BitmapDescriptor.hueGreen
                : BitmapDescriptor.hueOrange,
          ),
          infoWindow: InfoWindow(
            title: message.sender,
            snippet: message.message,
          ),
        ),
      );
    }

    // Add current user marker if position is available
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('current_user'),
          position: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(
            title: 'You',
            snippet: 'Your current location',
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            sender: 'You',
            message: _messageController.text.trim(),
            timestamp: DateTime.now(),
            location: _currentPosition != null
                ? LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  )
                : const LatLng(37.4219999, -122.0840575),
          ),
        );
      });
      _messageController.clear();

      // Auto scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // Scroll logic would go here for a scrollable chat
        }
      });
    }
  }

  void _sendEmergencyAlert() {
    setState(() {
      _messages.add(
        ChatMessage(
          sender: 'You',
          message: '🚨 EMERGENCY ALERT: Need immediate assistance!',
          timestamp: DateTime.now(),
          location: _currentPosition != null
              ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
              : const LatLng(37.4219999, -122.0840575),
          isEmergency: true,
        ),
      );
    });

    // Show emergency confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Emergency alert sent to all operators!',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF4757),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          'CHAT FORUM',
          style: GoogleFonts.orbitron(
            color: const Color(0xFF4ECDC4),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4ECDC4)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF4ECDC4).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFF4ECDC4), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.people, color: Color(0xFF4ECDC4), size: 16),
                const SizedBox(width: 4),
                Text(
                  '24',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4ECDC4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Map section
          Container(
            height: 200,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFF4ECDC4), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(
                    37.4219999,
                    -122.0840575,
                  ), // Default to Google HQ
                  zoom: 13.0,
                ),
                markers: _markers,
                mapType: MapType.terrain,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
          ),

          // Chat messages
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];
                  final isMe = message.sender == 'You';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        if (!isMe) ...[
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: const Color(0xFF4ECDC4),
                            child: Text(
                              message.sender[0].toUpperCase(),
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: message.isEmergency
                                  ? const Color(
                                      0xFFFF4757,
                                    ).withValues(alpha: 0.2)
                                  : isMe
                                  ? const Color(
                                      0xFF4ECDC4,
                                    ).withValues(alpha: 0.2)
                                  : const Color(0xFF2A2A2A),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: message.isEmergency
                                    ? const Color(0xFFFF4757)
                                    : isMe
                                    ? const Color(0xFF4ECDC4)
                                    : Colors.white.withValues(alpha: 0.1),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!isMe)
                                  Text(
                                    message.sender,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF4ECDC4),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                Text(
                                  message.message,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatTime(message.timestamp),
                                  style: GoogleFonts.inter(
                                    color: Colors.white60,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isMe) ...[
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: const Color(0xFF4ECDC4),
                            child: Text(
                              'Y',
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Message input
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Emergency alert button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _sendEmergencyAlert,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color(0xFFFF4757),
                          width: 1,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.warning,
                          color: Color(0xFFFF4757),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SEND EMERGENCY ALERT',
                          style: GoogleFonts.orbitron(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF4757),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Message input row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xFF4ECDC4),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _messageController,
                          style: GoogleFonts.inter(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: GoogleFonts.inter(color: Colors.white60),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ECDC4),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        onPressed: _sendMessage,
                        icon: const Icon(Icons.send, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;
  final LatLng location;
  final bool isEmergency;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
    required this.location,
    this.isEmergency = false,
  });
}
