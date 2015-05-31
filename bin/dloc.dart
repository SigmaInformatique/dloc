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

import 'dart:io';
import 'dart:collection';

import 'package:args/args.dart';
import 'package:dloc/dloc_util.dart';
import 'package:dloc/dloc_base.dart';

void _printLanguageInformation() {
  Map<String, String> map = new SplayTreeMap();

  langs.forEach((Lang lang) {
    String ext = lang.ext.pattern.replaceAll('.+', '').replaceAll('\$', '').replaceAll('\\', '').replaceAll('|', ',');
    map[lang.desc] = ext;
  });

  map.forEach((k, v) => print('${fillWithBlanks(k)} $v'));
}

void _doStart(List<String> arguments) {
  ArgResults argResults = parser.parse(arguments);

  //
  // Ask for a simple information?
  //

  if (argResults[SHOW_LANG]) {
    _printLanguageInformation();
    return;
  }

  //
  // Get argument rest and initialize
  //

  if (argResults.rest.length < 1) {
    print(parser.getUsage());
    exit(1);
  }

  initialize(new CommandLineArgs(argResults));

  //
  // Ask for a sum report?
  //

  if (argResults[SUM_REPORTS]) {
    aggregateInFile(argResults.rest, argResults[REPORT_FILE]);
    return;
  }

  //
  // Ask for a computation...
  //

  print('LOC computation started...\n');

  if (argResults[PRINT_CMD_DETAIL]) {
    options.printInfo();
  }

  var stopwatch = new Stopwatch()..start();

  // compute loc
  deleteFile(argResults[REPORT_FILE]);
  LocResult result = countLinesOfCode(argResults.rest[0]);

  // and print results
  if (!argResults[BY_FILE]) {
    // by file => not by lang
    result.printContent(argResults[REPORT_FILE]);
  }

  print("\nLOC computation done in: ${stopwatch.elapsedMilliseconds} ms");
}

void main(List<String> arguments) {
  _doStart(arguments);
}
