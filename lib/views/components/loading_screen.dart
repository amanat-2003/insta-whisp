import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insta_whisp/views/components/loading_view_controller.dart';
import 'package:insta_whisp/views/constants/strings.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  static final _shared = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _shared;

  LoadingViewController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.onUpdate(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.onRemove();
    _controller = null;
  }

  LoadingViewController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);

    final textController = StreamController<String>();
    textController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withOpacity(0.7),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height * 0.7,
                maxWidth: size.width * 0.7,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  30,
                  20,
                  20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
                        stream: textController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingViewController(
      onRemove: () {
        textController.close();
        overlay.remove();
        return true;
      },
      onUpdate: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
