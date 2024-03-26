import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../butterfly_api.dart';

part 'search.freezed.dart';

@freezed
sealed class SearchResult with _$SearchResult {
  const SearchResult._();

  const factory SearchResult.page(
    String name,
  ) = PageResult;
  const factory SearchResult.element(
    String text,
    String page,
    Point<double> position,
    PadElement element,
  ) = ElementResult;
  const factory SearchResult.area(
    Area area,
    String page,
  ) = AreaResult;
  const factory SearchResult.waypoint(
    Waypoint waypoint,
    String page,
  ) = WaypointResult;
  const factory SearchResult.tool(
    String name,
    Tool tool,
    int index,
  ) = ToolResult;

  String getDisplay() {
    return map(
      page: (value) => value.name,
      element: (value) => value.text,
      area: (value) => value.area.name,
      waypoint: (value) => value.waypoint.name,
      tool: (value) => value.name,
    );
  }

  String? getPage() {
    return maybeMap(
      page: (value) => value.name,
      element: (value) => value.page,
      area: (value) => value.page,
      waypoint: (value) => value.page,
      orElse: () => null,
    );
  }

  Point<double>? getPosition() {
    return maybeMap(
      element: (value) => value.position,
      area: (value) => value.area.position,
      waypoint: (value) => value.waypoint.position,
      orElse: () => null,
    );
  }

  SearchResult withPage(String page) => maybeMap(
        element: (value) => value.copyWith(page: page),
        page: (value) => value.copyWith(name: page),
        area: (value) => value.copyWith(page: page),
        waypoint: (value) => value.copyWith(page: page),
        orElse: () => this,
      );
}

extension ElementSearchHelper on PadElement {
  ElementResult? matches(Pattern query) {
    return mapOrNull(
      text: (value) {
        if (!value.area.paragraph.text.contains(query)) return null;
        return ElementResult(
          value.area.paragraph.text,
          '',
          value.position,
          this,
        );
      },
    );
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
    if (!name.contains(query)) return null;
    return WaypointResult(
      this,
      '',
    );
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
  Iterable<SearchResult> search(Pattern query,
      [String? currentPageName, DocumentPage? currentPage]) sync* {
    for (final pageName in getPages()) {
      final page =
          currentPageName == pageName ? currentPage : getPage(pageName);
      if (page == null) continue;
      if (pageName.contains(query)) yield PageResult(pageName);
      yield* page.search(query).map((e) => e.withPage(pageName));
    }
    yield* getInfo()?.search(query) ?? <SearchResult>[];
  }
}
