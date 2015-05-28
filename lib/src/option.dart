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

const RECURSIVE = 'recursive';
const FOLLOW_LINKS = 'follow-links';
const ENCODING = 'encoding';
const MATCH_FILE = 'match-f';
const NOT_MATCH_FILE = 'not-match-f';
const MATCH_DIR = 'match-d';
const NOT_MATCH_DIR = 'not-match-d';
const REPORT_FILE = 'report-file';
const BY_FILE = 'by-file';
const BY_FILE_BY_LANG = 'by-file-by-lang';
const BY_LANG = 'by-lang';
const PRINT_CMD_DETAIL = 'print-cmd-detail';
const SUM_REPORTS = 'sum-reports';
const SHOW_LANG = 'show-lang';

/// Store all program arguments.
abstract class Properties {
  operator [](String name);

  /// Prints properties either to `stdout` or to a file if [REPORT_FILE] exists.
  void printInfo();

  void _writeToFile(String content) {
    if (this[REPORT_FILE] != null) {
      String filename = this[REPORT_FILE] + '.info';
      deleteFile(filename);
      new File(filename)
        ..createSync(recursive: true)
        ..writeAsString(content);
      stdout.writeln('Wrote: ${filename}');
    } else {
      stdout.writeln(content);
    }
  }
}

/// Program arguments based on [ArgResults] ie for a command line invocation.
class CommandLineArgs extends Properties {
  ArgResults _args;

  CommandLineArgs(this._args);

  operator [](String name) {
    return _args[name];
  }

  void printInfo() {
    String content = _detailsAsString();
    _writeToFile(content);
  }

  String _detailsAsString() {
    bool veryDetailed = false;

    String content = '#\n# Used arguments are:\n';
    content += '#  dir=\'${_args.rest[0]}\'\n';
    _args.options.forEach((arg) => content += '#  $arg=${_args[arg]}\n');

    if (veryDetailed) {
      content += '#\n';
      content += '# Used regexp patterns are:\n';
      for (Lang each in langs) {
        content += '#  ${each.desc}=${each.ext.pattern}\n';
        content += '#    filename=${each.ext.pattern}\n';
        if (each.cmtSingle != null) {
          content += '#    comments (one-line)=${each.cmtSingle.pattern}\n';
        } else {
          content += '#    comments (one-line)=NA\n';
        }
        if (each.cmtMultiStarts != null) {
          for (int i = 0; i < each.cmtMultiStarts.length; i++) {
            content +=
                '#    comments (multi-line)=${each.cmtMultiStarts[i]},${each.cmtMultiEnds[i]}\n';
          }
        } else {
          content += '#    comments (multi-line)=NA\n';
        }
      }
    }

    content += '#\n';
    return content;
  }
}

// ============================================================================
// ArgResults implementation
// ============================================================================

final parser = new ArgParser()
  ..addFlag(RECURSIVE,
      help: 'Recurse into sub-directories',
      negatable: false,
      abbr: 'r',
      defaultsTo: true)
  ..addFlag(FOLLOW_LINKS,
      help: 'Recurse into links to directories', negatable: false, abbr: 'S')
  ..addOption(ENCODING,
      help: 'The encoding used (do not specify if unknown)',
      allowed: ["utf8", "latin1"])
  ..addOption(MATCH_DIR,
      help: 'Only count files in directories matching the regex')
  ..addOption(NOT_MATCH_DIR,
      help: 'Count all files except those in directories matching the regex')
  ..addOption(MATCH_FILE,
      help: 'Only count files whose basenames match the regex')
  ..addOption(NOT_MATCH_FILE,
      help: 'Count all files except those whose basenames match the regex')
  ..addOption(REPORT_FILE,
      help: 'Write the results to <file> file instead of STDOUT')
  ..addFlag(BY_FILE,
      help: 'Report results for every source file encountered',
      negatable: false)
  ..addFlag(BY_FILE_BY_LANG,
      help: 'Report results for every source file encountered in addition to reporting by language',
      negatable: false)
  ..addFlag(BY_LANG,
      help: 'Report results by language', negatable: false, defaultsTo: true)
  ..addFlag(PRINT_CMD_DETAIL,
      help: 'Print details about command args',
      negatable: false,
      defaultsTo: false)
  ..addFlag(SUM_REPORTS,
      help: 'Makes a cumulative set of results containing the sum of data from the individual report files',
      negatable: false)
  ..addFlag(SHOW_LANG,
      help: 'Print information about all known languages and exit',
      negatable: false);
