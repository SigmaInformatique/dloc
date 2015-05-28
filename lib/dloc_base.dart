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

library dloc_base;

import 'dart:io';
import 'dart:convert';
import 'dart:collection';

import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:dloc/dloc_util.dart';

part 'src/lang.dart';
part 'src/option.dart';
part 'src/count.dart';
part 'src/report.dart';

void initialize(Properties properties) {
  _initLog();
  _initOptions(properties);
}

//
// Options
//

Properties options = null;

void _initOptions(Properties properties) {
  options = properties;
}

//
// Logger
//

final Logger logger = new Logger('dloc');

void _initLog() {
  _initLogWith(null);
}

void _initLogWith(Level level) {
  if (level == null) {
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}



