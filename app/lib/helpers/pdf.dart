import 'package:butterfly_api/butterfly_api.dart';

/// Convert between PDF points (72 per inch) and canvas units (96 per inch).
const kPdfPointsPerCanvasUnit = 72 / kCanvasUnitsPerInch;

double canvasUnitsToPdfPoints(double value) => value * kPdfPointsPerCanvasUnit;

double pdfPointsToCanvasUnits(double value) => value / kPdfPointsPerCanvasUnit;
