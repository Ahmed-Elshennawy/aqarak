import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LocationSearchField extends StatefulWidget {
  final Function(String)? onLocationSelected;

  const LocationSearchField({super.key, this.onLocationSelected});

  @override
  LocationSearchFieldState createState() => LocationSearchFieldState();
}

class LocationSearchFieldState extends State<LocationSearchField> {
  final TextEditingController controller = TextEditingController();
  final _focusNode = FocusNode();
  final _layerLink = LayerLink();
  var _suggestions = <PlaceSuggestion>[];
  var _isLoading = false;
  Timer? _debounce;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      if (controller.text.isEmpty) _loadPopularEgyptianCities();
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _onTextChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => query.isEmpty ? _loadPopularEgyptianCities() : _searchPlaces(query),
    );
  }

  Future<void> _loadPopularEgyptianCities() async {
    setState(() => _isLoading = true);
    setState(() {
      _suggestions = LocationSearchConstants.egyptianCities
          .sublist(0, 10)
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
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&components=country:eg&key=${LocationSearchConstants.apiKey}',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(
          () => _suggestions = (data['predictions'] as List)
              .map(
                (pred) => PlaceSuggestion(
                  description: pred['description'],
                  placeId: pred['place_id'],
                ),
              )
              .toList(),
        );
      } else {
        _searchLocalPlaces(query);
      }
    } catch (e) {
      _searchLocalPlaces(query);
    }
    setState(() => _isLoading = false);
    _updateOverlay();
  }

  void _searchLocalPlaces(String query) {
    setState(
      () => _suggestions = LocationSearchConstants.egyptianCities
          .where((place) => place.toLowerCase().contains(query.toLowerCase()))
          .map(
            (place) => PlaceSuggestion(
              description: place,
              placeId: place.toLowerCase().replaceAll(' ', '_'),
            ),
          )
          .toList(),
    );
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 60),
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

  void _updateOverlay() => _overlayEntry?.markNeedsBuild();

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
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.blue),
          title: Text(_suggestions[index].description),
          onTap: () {
            controller.text = _suggestions[index].description;
            _focusNode.unfocus();
            _removeOverlay();
            widget.onLocationSelected?.call(_suggestions[index].description);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
    link: _layerLink,
    child: TextFormField(
      controller: controller,
      focusNode: _focusNode,
      onChanged: _onTextChanged,
      decoration: const InputDecoration(
        labelText: 'Where do you want',
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        prefixIcon: Icon(Icons.location_on_outlined, color: Colors.blue),
        suffixIcon: Icon(Icons.search),
      ),
    ),
  );
}

class PlaceSuggestion {
  final String description;
  final String placeId;

  PlaceSuggestion({required this.description, required this.placeId});
}
