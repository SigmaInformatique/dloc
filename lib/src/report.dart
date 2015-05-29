// Copyright 2015 SIGMA INFORMATIQUE, Société par actions simplifiée au capital de 1 649 600 Euros
// 8 Rue Newton – CS84533 - 44245 LA CHAPELLE-SUR-ERDRE CEDEX – FRANCE
// Tel : +33 (0) 2 40 37 14 00 – Fax : +33 (0) 2 40 37 72 20 – www.sigma.fr
// 872 803 390 R.C.S. NANTES – APE : 6202B – TVA : FR39 872 803 390
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of dloc_base;

class ReportData {
  Map<String, Map<String, int>> values = new SplayTreeMap();

  void addFileContent(String filename) {
    // Read all lines from file
    List<String> lines = new File(filename).readAsLinesSync();

    List<String> header = null;
    int langIdx = -1;

    for (String line in lines) {
      // Ignore comments and empty lines
      if (line.isEmpty || line.trimLeft().startsWith('#')) {
        continue;
      }

      // first line is header, build it
      if (header == null) {
        header = _splitLine(line);
        langIdx = header.indexOf('language');
        if (langIdx == -1) {
          throw 'A language column is expected';
        }
        continue;
      }

      // here: line with data (and not a header)
      List<String> lineValues = _splitLine(line);
      if (lineValues == null) {
        continue;
      }

      try {
        for (int i = 0; i < lineValues.length; i++) {
          String lang = lineValues[langIdx];
          if (i == langIdx) {
            continue;
          }
          if (values[lang] == null) {
            values[lang] = new Map();
          }
          String colh = header[i];
          if (values[lang][colh] == null) {
            values[lang][colh] = 0;
          }
          values[lang][colh] += int.parse(lineValues[i]);
        }
      }
      catch (exception) {
        throw 'Cannot parse file "$filename"';
      }
    }
  }

  static List<String> _splitLine(String line) {
    if (line.contains(',')) {
      return line.split(',');
    }
    if (line.contains(';')) {
      return line.split(';');
    }
    throw 'Cannot find separator';
  }

  Map<String, int> _buildHeader() {
    Map<String, int> header = new Map();
    header['language'] = 0;

    int idx = 1;
    values.forEach((lang, values) {
      values.forEach((col, value) {
        if (!header.containsKey(col)) {
          header[col] = idx++;
        }
      });
    });

    return header;
  }

  void add(ReportData other) {
    other.values.forEach((lang, map) {
      if (values[lang] == null) {
        values[lang] = new HashMap();
      }
      map.forEach((colh, value) {
        if (values[lang][colh] == null) {
          values[lang][colh] = 0;
        }
        values[lang][colh] += value;
      });
    });
  }

  void writeToFile(String out) {
    if (out == null) {
      stdout.writeln(values);
      return;
    }

    Map<String, int> idxs = _buildHeader();

    // manage header
    String content = '';
    for (String each in idxs.keys) {
      content += each + ';';
    }
    content = content.substring(0, content.length - 1);
    content += '\n';

    // manage values
    List<String> currentLine = new List(idxs.length);

    values.forEach((lang, vals) {
      currentLine.fillRange(0, idxs.length, '0');
      currentLine[idxs['language']] = lang;
      vals.forEach((col, val) {
        currentLine[idxs[col]] = val.toString();
      });
      for (var each in currentLine) {
        content += each + ';';
      }
      content = content.substring(0, content.length - 1);
      content += '\n';
    });


    if (new File(out).existsSync()) {
      logger.warning('Found previous file $out');
      deleteFile(out);
    }

    new File(out)
      ..createSync(recursive: true)
      ..writeAsStringSync(content);

    logger.info('Wrote: ${out}');
  }
}

/// Appends CSV line(s) to file
void _appendToFile(List<String> lines, String out, {bool stdoutIfNull : true}) {
  if (out == null) {
    if (stdoutIfNull) {
      lines.forEach((line) => stdout.writeln(line));
    }
    return;
  }

  // Here append to file
  String contentAsString = "";
  lines.forEach((line) {
    contentAsString += line.replaceAll(',', ';'); // wanted ';' as it opens easily in Excel
    contentAsString += "\n";
  });

  new File(out)
    ..createSync(recursive: true)
    ..writeAsStringSync(contentAsString, mode: FileMode.APPEND, flush: true);
}

/// Sums report files to a single ReportData.
ReportData aggregate(Iterable<String> inputReportFiles, {ReportData previous : null}) {
  ReportData data = (previous == null) ? new ReportData() : previous;
  for (String each in inputReportFiles) {
    data.addFileContent(each);
  }
  return data;
}


/// Sums report files to a single file if [out] is not null, to stdout otherwise.
void aggregateInFile(Iterable<String> inputReportFiles, String out) {
  if (inputReportFiles.length == 0) {
    return;
  }

  ReportData data = aggregate(inputReportFiles);

  if (out == null) {
    stdout.writeln(data.values);
    return;
  }

  if (inputReportFiles.length == 1) {
    new File(inputReportFiles.first).copy(out);
    return;
  }

  data.writeToFile(out);
}
