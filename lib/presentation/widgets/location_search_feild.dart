import 'package:aqarak/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LocationSearchField extends StatefulWidget {
  final Function(String)? onLocationSelected;

  const LocationSearchField({super.key, this.onLocationSelected});

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<PlaceSuggestion> _suggestions = [];
  bool _isLoading = false;
  Timer? _debounce;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  // Replace with your Google Places API key
  static const String _apiKey = 'YOUR_GOOGLE_PLACES_API_KEY';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      if (_controller.text.isEmpty) {
        _loadPopularEgyptianCities();
      }
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _onTextChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        _loadPopularEgyptianCities();
      } else {
        _searchPlaces(query);
      }
    });
  }

  Future<void> _loadPopularEgyptianCities() async {
    setState(() {
      _isLoading = true;
    });

    // Popular Egyptian cities - you can expand this list
    final popularCities = [
      'Cairo, Egypt',
      'Alexandria, Egypt',
      'Giza, Egypt',
      'Luxor, Egypt',
      'Aswan, Egypt',
      'Hurghada, Egypt',
      'Sharm El Sheikh, Egypt',
      'Port Said, Egypt',
      'Suez, Egypt',
      'Mansoura, Egypt',
    ];

    setState(() {
      _suggestions = popularCities
          .map(
            (city) => PlaceSuggestion(
              description: city,
              placeId: city.toLowerCase().replaceAll(' ', '_'),
            ),
          )
          .toList();
      _isLoading = false;
    });
    _updateOverlay();
  }

  Future<void> _searchPlaces(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Using Google Places API Autocomplete
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'input=$query&'
        'components=country:eg&' // Restrict to Egypt
        'key=$_apiKey',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final predictions = data['predictions'] as List;

        setState(() {
          _suggestions = predictions
              .map(
                (pred) => PlaceSuggestion(
                  description: pred['description'],
                  placeId: pred['place_id'],
                ),
              )
              .toList();
        });
      } else {
        // Fallback to local search if API fails
        _searchLocalPlaces(query);
      }
    } catch (e) {
      // Fallback to local search
      _searchLocalPlaces(query);
    }

    setState(() {
      _isLoading = false;
    });
    _updateOverlay();
  }

  void _searchLocalPlaces(String query) {
    // Fallback local search for Egyptian places
    final egyptianPlaces = [
      'Cairo, Egypt',
      'Alexandria, Egypt',
      'Giza, Egypt',
      'Luxor, Egypt',
      'Aswan, Egypt',
      'Hurghada, Egypt',
      'Sharm El Sheikh, Egypt',
      'Port Said, Egypt',
      'Suez, Egypt',
      'Mansoura, Egypt',
      'Tanta, Egypt',
      'Ismailia, Egypt',
      'Fayoum, Egypt',
      'Zagazig, Egypt',
      'Damietta, Egypt',
      'Minya, Egypt',
      'Sohag, Egypt',
      'Qena, Egypt',
      'Beni Suef, Egypt',
      'Red Sea, Egypt',
      'New Administrative Capital, Egypt',
      'Ain Sokhna, Egypt',
      'Marsa Alam, Egypt',
      'Dahab, Egypt',
      'Nuweiba, Egypt',
    ];

    final filteredPlaces = egyptianPlaces
        .where((place) => place.toLowerCase().contains(query.toLowerCase()))
        .map(
          (place) => PlaceSuggestion(
            description: place,
            placeId: place.toLowerCase().replaceAll(' ', '_'),
          ),
        )
        .toList();

    setState(() {
      _suggestions = filteredPlaces;
    });
  }

  void _showOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width:
            MediaQuery.of(context).size.width - 32, // Adjust based on padding
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 60), // Adjust based on TextField height
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: _buildSuggestionsList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildSuggestionsList() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_suggestions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No places found', style: TextStyle(color: Colors.grey)),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.backgroundDark
            : AppColors.backgroundLight,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return ListTile(
            leading: const Icon(Icons.location_on_outlined, color: Colors.blue),
            title: Text(suggestion.description),
            onTap: () {
              _controller.text = suggestion.description;
              _focusNode.unfocus();
              _removeOverlay();
              widget.onLocationSelected?.call(suggestion.description);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: _onTextChanged,
        decoration: const InputDecoration(
          labelText: 'Where do you want',
          labelStyle: TextStyle(
            fontSize: 16, // AppFonts.bodyLarge
            fontWeight: FontWeight.normal, // AppFonts.regular
          ),
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Colors.blue, // AppColors.accentBlue
          ),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class PlaceSuggestion {
  final String description;
  final String placeId;

  PlaceSuggestion({required this.description, required this.placeId});
}

// Usage example:
class LocationSearchExample extends StatelessWidget {
  const LocationSearchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Search')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LocationSearchField(
              onLocationSelected: (location) {
                print('Selected location: $location');
                // Handle the selected location
              },
            ),
          ],
        ),
      ),
    );
  }
}
