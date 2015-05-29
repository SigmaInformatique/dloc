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

// ============================================================================
// Classes
// ============================================================================

/// Result of a count operation for a single file.
class ResultByFile {
  int lines = 0;
  int blanks = 0;
  int comments = 0;

  void reset() {
    lines = 0;
    blanks = 0;
    comments = 0;
  }
}

/// Result of a count operation for a single language.
class ResultByLang {
  String desc = '';
  int files = 0;
  int lines = 0;
  int blanks = 0;
  int comments = 0;

  ResultByLang(this.desc);

  String toString() {
    return '[files=${files}, blanks=${blanks}, comments=${comments}, code=${lines}]';
  }
}

/// Result of a count operation.
class LocResult {
  final Map<RegExp, ResultByLang> data = new Map();

  LocResult() {
    for (Lang each in langs) {
      data[each.ext] = new ResultByLang(each.desc);
    }
  }

  void incOneFile(String filename, ResultByFile resByFile) {
    data.forEach((k, v) {
      if (k.hasMatch(filename)) {
        v.files++;
        v.lines += resByFile.lines;
        v.blanks += resByFile.blanks;
        v.comments += resByFile.comments;
        return;
      }
    });
  }

  void printContent(String reportFile) {
    if (reportFile == null) {
      _toStdout();
      return;
    }

    List<String> lines = new List();
    lines.add('files,language,blank,comment,code');
    data.forEach((k, v) {
      if (v.files > 0) {
        lines.add('${v.files},${v.desc},${v.blanks},${v.comments},${v.lines}');
      }
    });
    _appendToFile(lines, reportFile, stdoutIfNull: false);
    print('Wrote $reportFile');
  }

  void _toStdout() {
    List<String> lines = new List();

    String h1 = fillWithBlanks('files', 10);
    String h2 = fillWithBlanks('language', 25);
    String h3 = fillWithBlanks('blank', 10);
    String h4 = fillWithBlanks('comment', 10);
    String h5 = fillWithBlanks('code', 10);
    lines.add('$h1$h2$h3$h4$h5');

    data.forEach((k, v) {
      if (v.files > 0) {
        String c1 = fillWithBlanks('${v.files}', 10);
        String c2 = fillWithBlanks('${v.desc}', 25);
        String c3 = fillWithBlanks('${v.blanks}', 10);
        String c4 = fillWithBlanks('${v.comments}', 10);
        String c5 = fillWithBlanks('${v.lines}', 10);
        lines.add('$c1$c2$c3$c4$c5');
      }
    });

    _appendToFile(lines, null);
  }
}

// ============================================================================
// Functions
// ============================================================================

int _handleLine(File file, String line, Lang lang, int idxMultiComment,
                ResultByFile result) {
  // Ignore full line?
  if (lang.rmMatches != null && lang.rmMatches.hasMatch(line)) {
    return idxMultiComment;
  }

  // Should we care about a margin?
  if (lang.marginLgth != null && line.trim().isNotEmpty) {
    if (line.length < (lang.marginLgth)) {
      logger.warning('May be missing line \'$line\' for file: ${file.path}');
      return idxMultiComment;
    }
    line = line.substring(lang.marginLgth);
  }

  // Remove spaces
  line = line.trim();

  // Are we inside a multiline comment?
  if (idxMultiComment != -1) {
    // yes, looking for the closing chars
    int idx = line.indexOf(lang.cmtMultiEnds[idxMultiComment]);
    if (idx != -1) {
      String after = line
      .substring(idx + lang.cmtMultiEnds[idxMultiComment].length)
      .trim();
      if (after.isEmpty) {
        result.comments++;
      } else {
        result.lines++;
      }
      //print(">>>> Ending : ${line}");
      return -1;
    }
    result.comments++;
    return idxMultiComment;
  }

  // Is line empty?
  if (line.isEmpty) {
    result.blanks++;
    return idxMultiComment;
  }

  // Single line comment?
  if (lang.cmtSingle != null && lang.cmtSingle.hasMatch(line)) {
    result.comments++;
    return idxMultiComment;
  }

  // Ignore portions inside a line ?
  if (lang.rmInline != null && lang.rmInline.hasMatch(line)) {
    lang.rmInline.allMatches(line).forEach((m) {
      line = line.replaceFirst(m.group(0), '');
    });
  }

  // Does a multiline comment begin?
  if (idxMultiComment == -1 && lang.cmtMultiStarts != null) {
    int firstIdx = -1;
    for (int i = 0; i < lang.cmtMultiStarts.length; i++) {
      int containsIdx = line.indexOf(lang.cmtMultiStarts[i]);
      if (containsIdx != -1) {
        if (firstIdx == -1 || firstIdx > containsIdx) {
          firstIdx = containsIdx;
          idxMultiComment = i;
        }
      }
    }
    if (idxMultiComment != -1) {
      bool insideString = false;
      if (firstIdx != 0) {
        // may be inside a string...
        String before = line.substring(0, firstIdx);
        int n1 = new RegExp('\'').allMatches(before).length;
        int n2 = new RegExp('"').allMatches(before).length;
        if ((n1 % 2) != 0 || (n2 % 2) != 0) {
          insideString = true;
          idxMultiComment = -1;
          // ignoring
        }
      }
      if (!insideString) {
        int idxStart = line.indexOf(lang.cmtMultiStarts[idxMultiComment]);
        if (idxStart != -1) {
          //print(">>>> Begining : ${line}");

          int idxEnd =
          line.indexOf(lang.cmtMultiEnds[idxMultiComment], idxStart);
          if (idxEnd != -1) {
            String after = line
            .substring(idxEnd + lang.cmtMultiEnds[idxMultiComment].length)
            .trim();
            if (idxStart > 0 || after.isNotEmpty) {
              result.lines++;
            } else {
              result.comments++;
            }
            //print(">>>> Ending : ${line}");
            return -1;
          }

          if (idxStart > 0) {
            result.lines++;
          } else {
            result.comments++;
          }
          return idxMultiComment;
        }
      }
    }
  }

  // Here: should be safe to count the line as code
  result.lines++;
  return -1;
}

ResultByFile _linesInFileGuessingCharset(
    File file, String filename, Lang lang, LocResult result) {
  ResultByFile resByFile = new ResultByFile();
  int idxMultiComment = -1;
  try {
    file.readAsLinesSync(encoding: UTF8).forEach((line) {
      idxMultiComment =
      _handleLine(file, line, lang, idxMultiComment, resByFile);
    });
  } on FileSystemException {
    resByFile.reset();
    idxMultiComment = -1;
    file.readAsLinesSync(encoding: LATIN1).forEach((line) {
      idxMultiComment =
      _handleLine(file, line, lang, idxMultiComment, resByFile);
    });
  }
  if (idxMultiComment != -1) {
    logger.severe("Issue with mutliline comment for: ${file.path}");
  }
  result.incOneFile(filename, resByFile);
  return resByFile;
}

ResultByFile _linesInFileKnowingCharset(
    File file, Encoding charset, String filename, Lang lang, LocResult result) {
  ResultByFile resByFile = new ResultByFile();
  int idxMultiComment = -1;
  file.readAsLinesSync(encoding: charset).forEach((line) {
    idxMultiComment = _handleLine(file, line, lang, idxMultiComment, resByFile);
  });
  if (idxMultiComment != -1) {
    logger.severe("Issue with mutliline comment for: ${file.path}");
  }
  result.incOneFile(filename, resByFile);
  return resByFile;
}

ResultByFile _linesInFile(
    File file, String charset, String filename, Lang lang, LocResult result) {
  if (charset == null) {
    return _linesInFileGuessingCharset(file, filename, lang, result);
  }
  return _linesInFileKnowingCharset(
      file, ("latin1" == charset) ? LATIN1 : UTF8, filename, lang, result);
}

void _processFile(File entity, Map<String, RegExp> matchers, LocResult result) {
  String dirname = parent(entity);
  String filename = lastSegment(entity);

  if (matchers[NOT_MATCH_DIR] != null &&
  matchers[NOT_MATCH_DIR].hasMatch(dirname)) {
    return;
  }
  if (matchers[NOT_MATCH_FILE] != null &&
  matchers[NOT_MATCH_FILE].hasMatch(filename)) {
    return;
  }
  if (matchers[MATCH_DIR] != null && !matchers[MATCH_DIR].hasMatch(dirname)) {
    return;
  }
  if (matchers[MATCH_FILE] != null &&
  !matchers[MATCH_FILE].hasMatch(filename)) {
    return;
  }

  Lang lang = hasMatch(filename);
  if (lang == null) {
    return;
  }

  // print("Current entity: ${entity}");

  ResultByFile resByFile =
  _linesInFile(entity, options[ENCODING], filename, lang, result);

  if (options[BY_FILE] || options[BY_FILE_BY_LANG]) {
    _appendToFile(['filename,blank,comment,code'], options[REPORT_FILE]);
    _appendToFile(["${toForwardSlash(entity.path)},${resByFile.blanks},${resByFile.comments},${resByFile.lines} \n"],
        options[REPORT_FILE]);
  }
}

/// Counts lines of code using the given path.
///
/// - [root] could be a single file or a root directory.
LocResult countLinesOfCode(String root) {
  final Map<String, RegExp> matchers = {
    MATCH_FILE:
    options[MATCH_FILE] == null ? null : new RegExp(options[MATCH_FILE]),
    NOT_MATCH_FILE: options[NOT_MATCH_FILE] == null
    ? null
    : new RegExp(options[NOT_MATCH_FILE]),
    MATCH_DIR:
    options[MATCH_DIR] == null ? null : new RegExp(options[MATCH_DIR]),
    NOT_MATCH_DIR: options[NOT_MATCH_DIR] == null
    ? null
    : new RegExp(options[NOT_MATCH_DIR])
  };

  LocResult result = new LocResult();

  // Single file case?
  if (!FileSystemEntity.isDirectorySync(root)) {
    if (FileSystemEntity.isFileSync(root)) {
      _processFile(new File(root), matchers, result);
    }
    return result;
  }

  final startingDir = new Directory(root);
  List<FileSystemEntity> each = startingDir.listSync(
      recursive: options[RECURSIVE], followLinks: options[FOLLOW_LINKS]);
  each.forEach((entity) {
    if (entity is! File) {
      return;
    }
    _processFile(entity, matchers, result);
  });

  return result;
}
