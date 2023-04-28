import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/src/models/text.dart';

import '../converter/note.dart';
import 'archive.dart';
import 'meta.dart';
import 'pack.dart';
import 'page.dart';
import 'palette.dart';

// 16:9
const kThumbnailWidth = 640;
const kThumbnailHeight = 360;

// Archive specific
const kMetaInfoArchiveDirectory = 'META-INF';
const kMetaArchiveFile = '$kMetaInfoArchiveDirectory/butterfly.json';
const kMetaBflyArchiveDirectory = '$kMetaInfoArchiveDirectory/BFLY';
const kThumbnailArchiveFile = '$kMetaBflyArchiveDirectory/thumbnail.png';
// Document specific
const kPaintersArchiveFile = '$kMetaBflyArchiveDirectory/painters.json';
const kFontsArchiveDirectory = '$kMetaBflyArchiveDirectory/fonts';
const kImagesArchiveDirectory = '$kMetaBflyArchiveDirectory/images';
const kPacksArchiveDirectory = '$kMetaBflyArchiveDirectory/packs';
const kPagesArchiveDirectory = '$kMetaBflyArchiveDirectory/pages';
// Pack specific
const kComponentsArchiveDirectory = '$kMetaBflyArchiveDirectory/components';
const kStylesArchiveDirectory = '$kMetaBflyArchiveDirectory/styles';
const kPalettesArchiveDirectory = '$kMetaBflyArchiveDirectory/palettes';
