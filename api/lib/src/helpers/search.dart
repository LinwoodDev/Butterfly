import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../butterfly_api.dart';

part 'search.freezed.dart';

@freezed
sealed class SearchResult with _$SearchResult {
  const SearchResult._();

  const factory SearchResult.page(String name) = PageResult;
  const factory SearchResult.element(
    String text,
    String page,
    Point<double> position,
    PadElement element,
  ) = ElementResult;
  const factory SearchResult.area(Area area, String page) = AreaResult;
  const factory SearchResult.waypoint(Waypoint waypoint, String page) =
      WaypointResult;
  const factory SearchResult.tool(String name, Tool tool, int index) =
      ToolResult;

  String? getPage() => switch (this) {
    PageResult e => e.name,
    ElementResult e => e.page,
    AreaResult e => e.page,
    WaypointResult e => e.page,
    _ => null,
  };

  Point<double>? getPosition() => switch (this) {
    ElementResult e => e.position,
    AreaResult e => e.area.position,
    WaypointResult e => e.waypoint.position,
    _ => null,
  };

  SearchResult withPage(String page) => switch (this) {
    ElementResult e => e.copyWith(page: page),
    PageResult e => e.copyWith(name: page),
    AreaResult e => e.copyWith(page: page),
    WaypointResult e => e.copyWith(page: page),
    _ => this,
  };
}

extension ElementSearchHelper on PadElement {
  ElementResult? matches(Pattern query) {
    ElementResult? matchText(TextElement e) {
      if (!e.area.paragraph.text.contains(query)) return null;
      return ElementResult(e.area.paragraph.text, '', e.position, this);
    }

    return switch (this) {
      TextElement e => matchText(e),
      _ => null,
    };
  }
}

extension AreaSearchHelper on Area {
  AreaResult? matches(Pattern query) {
    if (!name.contains(query)) return null;
    return AreaResult(this, '');
  }
}

extension WaypointSearchHelper on Waypoint {
  WaypointResult? matches(Pattern query) {
    if (name != null && name!.contains(query)) return null;
    return WaypointResult(this, '');
  }
}

extension PageSearchHelper on DocumentPage {
  Iterable<SearchResult> search(Pattern query) sync* {
    for (final area in areas) {
      final result = area.matches(query);
      if (result != null) yield result;
    }
    for (final waypoint in waypoints) {
      final result = waypoint.matches(query);
      if (result != null) yield result;
    }
    for (final element in content) {
      final result = element.matches(query);
      if (result != null) yield result;
    }
  }
}

extension ToolSearchHelper on Tool {
  ToolResult? matches(Pattern query, int index) {
    if (!name.contains(query)) return null;
    return ToolResult(name, this, index);
  }
}

extension DocumentInfoSearchHelper on DocumentInfo {
  Iterable<SearchResult> search(Pattern query) sync* {
    for (final tool in tools.asMap().entries) {
      final result = tool.value.matches(query, tool.key);
      if (result != null) yield result;
    }
  }
}

extension GlobalSearchHelper on NoteData {
  Iterable<SearchResult> search(
    Pattern query, [
    String? currentPageName,
    DocumentPage? currentPage,
  ]) sync* {
    for (final pageName in getPages()) {
      final page = currentPageName == pageName
          ? currentPage
          : getPage(pageName);
      if (page == null) continue;
      if (pageName.contains(query)) yield PageResult(pageName);
      yield* page.search(query).map((e) => e.withPage(pageName));
    }
    yield* getInfo()?.search(query) ?? <SearchResult>[];
  }
}
