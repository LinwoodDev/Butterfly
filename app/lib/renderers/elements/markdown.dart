part of '../renderer.dart';

class MarkdownRenderer extends Renderer<MarkdownElement> {
  @override
  Rect rect = Rect.zero;
  MarkdownContext? context;

  MarkdownRenderer(super.element, [this.context]);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {}
}
