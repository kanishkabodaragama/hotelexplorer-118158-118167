import 'package:flutter/material.dart';
import '../widgets/hotel_card.dart';
import '../models/hotel.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_chip_widget.dart';

// PUBLIC_INTERFACE
class HotelsScreen extends StatefulWidget {
  /// Main hotels listing screen with search and filter functionality
  const HotelsScreen({super.key});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  String _searchQuery = '';
  List<String> _selectedFilters = [];

  // Sample hotel data for demonstration
  final List<Hotel> _hotels = [
    Hotel(
      id: '1',
      name: 'Grand Plaza Hotel',
      location: 'New York, NY',
      price: 299.99,
      rating: 4.5,
      imageUrl: 'https://via.placeholder.com/300x200',
      amenities: ['WiFi', 'Pool', 'Gym', 'Restaurant'],
    ),
    Hotel(
      id: '2',
      name: 'Ocean View Resort',
      location: 'Miami, FL',
      price: 399.99,
      rating: 4.8,
      imageUrl: 'https://via.placeholder.com/300x200',
      amenities: ['WiFi', 'Beach', 'Spa', 'Restaurant'],
    ),
    Hotel(
      id: '3',
      name: 'City Center Inn',
      location: 'Chicago, IL',
      price: 199.99,
      rating: 4.2,
      imageUrl: 'https://via.placeholder.com/300x200',
      amenities: ['WiFi', 'Parking', 'Business Center'],
    ),
    Hotel(
      id: '4',
      name: 'Mountain Lodge',
      location: 'Denver, CO',
      price: 249.99,
      rating: 4.6,
      imageUrl: 'https://via.placeholder.com/300x200',
      amenities: ['WiFi', 'Fireplace', 'Hiking', 'Restaurant'],
    ),
  ];

  List<Hotel> get _filteredHotels {
    return _hotels.where((hotel) {
      final matchesSearch = hotel.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          hotel.location.toLowerCase().contains(_searchQuery.toLowerCase());
      
      if (_selectedFilters.isEmpty) return matchesSearch;
      
      final matchesFilters = _selectedFilters.every((filter) {
        switch (filter) {
          case 'High Rating':
            return hotel.rating >= 4.5;
          case 'Under \$250':
            return hotel.price < 250;
          case 'Pool':
            return hotel.amenities.contains('Pool');
          case 'WiFi':
            return hotel.amenities.contains('WiFi');
          default:
            return true;
        }
      });
      
      return matchesSearch && matchesFilters;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotels'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sort functionality
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarWidget(
              onSearch: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
          
          // Filter Chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FilterChipWidget(
                  label: 'High Rating',
                  isSelected: _selectedFilters.contains('High Rating'),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedFilters.add('High Rating');
                      } else {
                        _selectedFilters.remove('High Rating');
                      }
                    });
                  },
                ),
                FilterChipWidget(
                  label: 'Under \$250',
                  isSelected: _selectedFilters.contains('Under \$250'),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedFilters.add('Under \$250');
                      } else {
                        _selectedFilters.remove('Under \$250');
                      }
                    });
                  },
                ),
                FilterChipWidget(
                  label: 'Pool',
                  isSelected: _selectedFilters.contains('Pool'),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedFilters.add('Pool');
                      } else {
                        _selectedFilters.remove('Pool');
                      }
                    });
                  },
                ),
                FilterChipWidget(
                  label: 'WiFi',
                  isSelected: _selectedFilters.contains('WiFi'),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedFilters.add('WiFi');
                      } else {
                        _selectedFilters.remove('WiFi');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Hotel List
          Expanded(
            child: _filteredHotels.isEmpty
                ? const Center(
                    child: Text(
                      'No hotels found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredHotels.length,
                    itemBuilder: (context, index) {
                      return HotelCard(hotel: _filteredHotels[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement new search functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New search feature coming soon!')),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
