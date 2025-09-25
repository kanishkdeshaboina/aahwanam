import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/custom_text_field.dart';

class MediaGallery extends StatelessWidget {
  final List<Map<String, dynamic>> media;

  const MediaGallery({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Media: $media");

    if (media.isEmpty) {
      return const Center(child: Text("No media available"));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(  // ✅ Add scrolling capability if needed
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,  // ✅ Take minimum space needed
            children: [
              /// ✅ Title
              Text(
                "Photos And Videos",
                style: TextFontStyle.textFontStyle(
                  15,
                  const Color(0xFF575959),
                  FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              /// ✅ Grid without Flexible/Expanded - takes only needed space
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true, // ✅ Only take space needed for content
                physics: const NeverScrollableScrollPhysics(), // ✅ Disable internal scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemCount: media.length > 9 ? 9 : media.length,
                itemBuilder: (context, index) {
                  final item = media[index];
                  final String url = item['url'];
                  final bool isVideo = item['isVideo'] ?? false;

                  return GestureDetector(
                    onTap: () {
                      if (isVideo) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoPlayerScreen(videoUrl: url),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullScreenImageViewer(
                              images: media
                                  .where((m) => m['isVideo'] == false)
                                  .map((m) => m['url'] as String)
                                  .toList(),
                              initialIndex: media
                                  .where((m) => m['isVideo'] == false)
                                  .toList()
                                  .indexOf(item),
                            ),
                          ),
                        );
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(url, fit: BoxFit.cover),
                          if (isVideo)
                            Container(
                              color: Colors.black26,
                              child: const Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageViewer({Key? key, required this.images, required this.initialIndex})
      : super(key: key);

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${currentIndex + 1} / ${widget.images.length}',
            style: TextFontStyle.textFontStyle( 14, Colors.white,FontWeight.w500)),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) => setState(() => currentIndex = index),
        itemBuilder: (context, index) {
          return Center(
            child: Image.asset(widget.images[index], fit: BoxFit.contain),
          );
        },
      ),
    );
  }
}

/// Video Player Screen
class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          isInitialized = true;
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : const CircularProgressIndicator(color: Colors.white),
      ),
      floatingActionButton: isInitialized
          ? FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      )
          : null,
    );
  }
}