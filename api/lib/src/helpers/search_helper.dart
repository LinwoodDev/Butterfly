import 'dart:math';

import '../../butterfly_api.dart';

class SearchResult<T> {
  final String name;
  final Point<double> location;
  final T item;

  SearchResult(this.name, this.location, this.item);
}

extension ElementSearchHelper on PadElement {
  SearchResult<PadElement>? matches(Pattern query) {
    return maybeMap(
      text: (value) {
        if (!value.area.paragraph.text.contains(query)) return null;
        return SearchResult(
          value.area.paragraph.text,
          value.position,
          this,
        );
      },
      orElse: () => null,
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

extension SearchHelper on DocumentPage {
  List<SearchResult> search(Pattern query) {
    final results = <SearchResult>[];
    for (final area in areas) {
      final result = area.matches(query);
      if (result != null) results.add(result);
    }
    for (final waypoint in waypoints) {
      final result = waypoint.matches(query);
      if (result != null) results.add(result);
    }
    for (final element in content) {
      final result = element.matches(query);
      if (result != null) results.add(result);
    }
    return results;
  }
}
