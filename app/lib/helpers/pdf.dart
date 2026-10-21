/// PDF import/export maps one canvas unit to one millimeter.
const kPdfPointsPerCanvasUnit = 72 / 25.4;

double canvasUnitsToPdfPoints(double value) => value * kPdfPointsPerCanvasUnit;

double pdfPointsToCanvasUnits(double value) => value / kPdfPointsPerCanvasUnit;
