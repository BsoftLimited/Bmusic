import 'package:flutter/material.dart';

class SmoothTabBarAppBar extends StatefulWidget {
  const SmoothTabBarAppBar({super.key});

  @override
  State<SmoothTabBarAppBar> createState() => _SmoothTabBarAppBarState();
}

class _SmoothTabBarAppBarState extends State<SmoothTabBarAppBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  final double _maxOffset = 150;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset.clamp(0, _maxOffset).toDouble();
    });
  }

  Color get _appBarColor {
    final opacity = (_scrollOffset / _maxOffset).clamp(0, 1) * 255;
    return Colors.white.withAlpha(opacity.ceil());
  }

  Color get _tabBarColor {
    final opacity = (_scrollOffset / _maxOffset).clamp(0, 1) * 255;
    return Colors.white.withAlpha(opacity.ceil());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 300,
                floating: true,
                pinned: true,
                backgroundColor: _appBarColor,
                elevation: _scrollOffset > _maxOffset * 0.7 ? 4 : 0,
                title: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _scrollOffset > _maxOffset * 0.5 ? 1 : 0,
                  child: const Text(
                    'My App',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    children: [
                      Image.network(
                        'https://picsum.photos/1200/800',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome Back!',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'This is your personalized dashboard',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: Container(
                    color: _tabBarColor,
                    child: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
                        Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
                        Tab(icon: Icon(Icons.history), text: 'History'),
                      ],
                      indicatorColor: Colors.blue,
                      labelColor: Colors.blue,
                      unselectedLabelColor: _scrollOffset > _maxOffset * 0.5
                          ? Colors.grey
                          : Colors.white70,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildTabView('Dashboard'),
              _buildTabView('Analytics'),
              _buildTabView('History'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabView(String title) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: 30,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title - Item ${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Description for $title item ${index + 1}. '
                    'This is some sample content.',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}