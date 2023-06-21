import 'dart:math';

import '../../butterfly_api.dart';

class SearchResult<T> {
  final String name;
  final Point<double> location;
  final String? page;
  final T item;

  SearchResult(this.name, this.location, this.item, [this.page]);

  SearchResult withPage(String page) => SearchResult(
        name,
        location,
        item,
        page,
      );
}

extension ElementSearchHelper on PadElement {
  SearchResult<PadElement>? matches(Pattern query) {
    return mapOrNull(
      text: (value) {
        if (!value.area.paragraph.text.contains(query)) return null;
        return SearchResult(
          value.area.paragraph.text,
          value.position,
          this,
        );
      },
    );
  }
}

extension AreaSearchHelper on Area {
  SearchResult<Area>? matches(Pattern query) {
    if (!name.contains(query)) return null;
    return SearchResult(
      name,
      Point(0, 0),
      this,
    );
  }
}

extension WaypointSearchHelper on Waypoint {
  SearchResult<Waypoint>? matches(Pattern query) {
    if (!name.contains(query)) return null;
    return SearchResult(
      name,
      -position,
      this,
    );
  }
}

extension GlobalSearchHelper on NoteData {
  Iterable<SearchResult> search(Pattern query) sync* {
    for (final pageName in getPages()) {
      final page = getPage(pageName);
      if (page == null) continue;
      yield SearchResult(pageName, Point(0, 0), page, pageName);
      yield* page.search(query).map((e) => e.withPage(pageName));
    }
  }
}

extension SearchHelper on DocumentPage {
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
