import 'package:flutter/material.dart';

class NoteFormatter {
  List<TextSpan> formatForDisplay(String notes) {
    final lines = notes.split('\n');
    final spans = <TextSpan>[];

    for (var line in lines) {
      if (line.isEmpty) continue;

      if (RegExp(r'^\d+').hasMatch(line)) {
        spans.add(
          TextSpan(
            text: '$line\n\n',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      } else if (line.startsWith('*')) {
        spans.add(
          TextSpan(
            text: '$line\n\n',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$line\n\n',
            style: const TextStyle(fontSize: 20),
          ),
        );
      }
    }

    return spans;
  }

  String formatForFocusPage(String notes) {
    final lines = notes.split('\n');
    return lines.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final line = entry.value;

      if (line.isEmpty) return line;

      if (RegExp(r'^\d+|\*|[+-]').hasMatch(line)) {
        return line;
      } else {
        return '$index) $line\n';
      }
    }).join('\n');
  }

  String formatForControlPage(String notes) {
    final lines = notes.split('\n');
    return lines.map((line) {
      if (line.isEmpty) return line; // Boş satırları olduğu gibi bırak
      if (RegExp(r'^\d+|\*|[+-]').hasMatch(line)) {
        return line;
      } else {
        return '* $line\n';
      }
    }).join('\n');
  }

  String formatForPlanPage(String notes) {
    final lines = notes.split('\n');
    return lines.map((line) {
      if (line.isEmpty) return line;
      if (RegExp(r'^\d+|\*|[+-]').hasMatch(line)) {
        return line;
      } else {
        return '- $line';
      }
    }).join('\n');
  }
   String formatForStartPage(List<String> lines, List<bool> isChecked) {
    return lines.asMap().entries.map((entry) {
      final index = entry.key;
      final line = entry.value;

      if (line.isEmpty) return line;
      if (RegExp(r'^[+-]').hasMatch(line)) {
        return (isChecked[index] ? '+ ' : '-') + line.substring(1).trim();
      } else {
        return line;
      }
    }).join('\n');
  }
}
