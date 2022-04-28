// Copyright (c) 2022 Mantano. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mno_commons/utils/predicate.dart';
import 'package:mno_navigator/epub.dart';
import 'package:mno_navigator/publication.dart';
import 'package:mno_shared/publication.dart';

abstract class ReaderAnnotationRepository {
  final StreamController<List<String>> _deletedIdsController;

  ReaderAnnotationRepository()
      : this._deletedIdsController = StreamController.broadcast();

  Future<ReaderAnnotation> createBookmark(PaginationInfo paginationInfo);

  Future<ReaderAnnotation> createHighlight(
      Locator locator, HighlightStyle style, int tint);

  Future<ReaderAnnotation?> get(String id);

  void delete(List<String> deletedIds);

  Future<List<ReaderAnnotation>> allWhere({
    Predicate<ReaderAnnotation> predicate = const AcceptAllPredicate(),
  });

  void notifyDeletedIds(List<String> deletedIds) =>
      _deletedIdsController.add(deletedIds);

  Stream<List<String>> get deletedIdsStream => _deletedIdsController.stream;

  void save(ReaderAnnotation readerAnnotation);
}
