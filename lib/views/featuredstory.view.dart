import 'package:flutter/material.dart';

class FeaturedStoryView extends StatefulWidget {
  final String title;
  final List<String> images; // multiple story images
  final List<FeaturedStoryView> allStories; // list of all featured story sets
  final int storyIndex; // current story set index

  const FeaturedStoryView({
    super.key,
    required this.title,
    required this.images,
    required this.allStories,
    required this.storyIndex,
  });

  @override
  State<FeaturedStoryView> createState() => _FeaturedStoryViewState();
}

class _FeaturedStoryViewState extends State<FeaturedStoryView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // story duration
    );

    _startStory();
  }

  void _startStory() {
    _animController.forward(from: 0);
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextPage();
      }
    });
  }

  void _nextPage() {
    if (currentIndex < widget.images.length - 1) {
      setState(() => currentIndex++);
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animController.forward(from: 0);
    } else {
      _goToNextFeaturedStory();
    }
  }

  void _previousPage() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animController.forward(from: 0);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _goToNextFeaturedStory() {
    final nextIndex = widget.storyIndex + 1;
    if (nextIndex < widget.allStories.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.allStories[nextIndex]),
      );
    } else {
      Navigator.of(context).maybePop(); // no more stories → close
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Story content
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Image.asset(
                widget.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),

          /// Top progress bars + title + close
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Progress bars
                Row(
                  children: List.generate(widget.images.length, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: index < currentIndex
                                ? 1
                                : index == currentIndex
                                ? _animController.value
                                : 0,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            minHeight: 3,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),

                /// Title + close button
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Tap zones (Instagram-like)
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _previousPage,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _nextPage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
