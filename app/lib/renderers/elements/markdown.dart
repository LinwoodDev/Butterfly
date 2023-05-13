part of '../renderer.dart';

class MarkdownRenderer extends Renderer<MarkdownElement> {
  @override
  Rect rect = Rect.zero;

  MarkdownRenderer(super.element);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {}
}
