//@dart=2.9
import 'dart:convert';

TextRecognitionResponse textRecognitionResponseFromJson(String str) =>
    TextRecognitionResponse.fromJson(json.decode(str));
String textRecognitionResponseToJson(TextRecognitionResponse data) =>
    json.encode(data.toJson());

class TextRecognitionResponse {
  TextRecognitionResponse({
    this.parsedResults,
    this.ocrExitCode,
    this.isErroredOnProcessing,
    this.processingTimeInMilliseconds,
    this.searchablePdfurl,
  });

  List<ParsedResult> parsedResults;
  int ocrExitCode;
  bool isErroredOnProcessing;
  String processingTimeInMilliseconds;
  String searchablePdfurl;

  factory TextRecognitionResponse.fromJson(Map<String, dynamic> json) =>
      TextRecognitionResponse(
        parsedResults: json["ParsedResults"] == null
            ? null
            : List<ParsedResult>.from(
                json["ParsedResults"].map((x) => ParsedResult.fromJson(x))),
        ocrExitCode: json["OCRExitCode"] == null ? null : json["OCRExitCode"],
        isErroredOnProcessing: json["IsErroredOnProcessing"] == null
            ? null
            : json["IsErroredOnProcessing"],
        processingTimeInMilliseconds:
            json["ProcessingTimeInMilliseconds"] == null
                ? null
                : json["ProcessingTimeInMilliseconds"],
        searchablePdfurl:
            json["SearchablePDFURL"] == null ? null : json["SearchablePDFURL"],
      );

  Map<String, dynamic> toJson() => {
        "ParsedResults": parsedResults == null
            ? null
            : List<dynamic>.from(parsedResults.map((x) => x.toJson())),
        "OCRExitCode": ocrExitCode == null ? null : ocrExitCode,
        "IsErroredOnProcessing":
            isErroredOnProcessing == null ? null : isErroredOnProcessing,
        "ProcessingTimeInMilliseconds": processingTimeInMilliseconds == null
            ? null
            : processingTimeInMilliseconds,
        "SearchablePDFURL": searchablePdfurl == null ? null : searchablePdfurl,
      };
}

class ParsedResult {
  ParsedResult({
    this.textOverlay,
    this.textOrientation,
    this.fileParseExitCode,
    this.parsedText,
    this.errorMessage,
    this.errorDetails,
  });

  TextOverlay textOverlay;
  String textOrientation;
  int fileParseExitCode;
  String parsedText;
  String errorMessage;
  String errorDetails;

  factory ParsedResult.fromJson(Map<String, dynamic> json) => ParsedResult(
        textOverlay: json["TextOverlay"] == null
            ? null
            : TextOverlay.fromJson(json["TextOverlay"]),
        textOrientation:
            json["TextOrientation"] == null ? null : json["TextOrientation"],
        fileParseExitCode: json["FileParseExitCode"] == null
            ? null
            : json["FileParseExitCode"],
        parsedText: json["ParsedText"] == null ? null : json["ParsedText"],
        errorMessage:
            json["ErrorMessage"] == null ? null : json["ErrorMessage"],
        errorDetails:
            json["ErrorDetails"] == null ? null : json["ErrorDetails"],
      );

  Map<String, dynamic> toJson() => {
        "TextOverlay": textOverlay == null ? null : textOverlay.toJson(),
        "TextOrientation": textOrientation == null ? null : textOrientation,
        "FileParseExitCode":
            fileParseExitCode == null ? null : fileParseExitCode,
        "ParsedText": parsedText == null ? null : parsedText,
        "ErrorMessage": errorMessage == null ? null : errorMessage,
        "ErrorDetails": errorDetails == null ? null : errorDetails,
      };
}

class TextOverlay {
  TextOverlay({
    this.lines,
    this.hasOverlay,
    this.message,
  });

  List<dynamic> lines;
  bool hasOverlay;
  String message;

  factory TextOverlay.fromJson(Map<String, dynamic> json) => TextOverlay(
        lines: json["Lines"] == null
            ? null
            : List<dynamic>.from(json["Lines"].map((x) => x)),
        hasOverlay: json["HasOverlay"] == null ? null : json["HasOverlay"],
        message: json["Message"] == null ? null : json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Lines": lines == null ? null : List<dynamic>.from(lines.map((x) => x)),
        "HasOverlay": hasOverlay == null ? null : hasOverlay,
        "Message": message == null ? null : message,
      };
}
