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

import 'package:test/test.dart';
import 'package:dloc/dloc_util.dart';
import 'package:dloc/dloc_base.dart';

List<String> getFilesFromDir(String dir) {
  List<String> result = [];
  new Directory(dir).listSync().forEach((e) => result.add(toForwardSlash(e.path)));
  return result;
}

void doTest() {
  String root = '${Directory.current.path}/data';
  List<String> files = [root + '/report/dloc-sub1.csv', root + '/report/dloc-sub2.csv'];
  ReportData data = aggregate(files);

  // var tmpDir = Directory.systemTemp.toString();
  var tmpDir = root;

  data.writeToFile(tmpDir + '/out/out.csv');
  aggregateInFile(files, tmpDir + '/out/out2.csv');

  String str1 = new File(tmpDir + '/out/out.csv').readAsStringSync();
  String str2 = new File(tmpDir + '/out/out2.csv').readAsStringSync();

  String expected = '''
language;files;blank;comment;code
Bourne Shell;15;166;335;608
DOS Batch;39;99;11;391
Delphi;2088;200221;330892;1909885
Delphi Forms;436;2153;0;195299
HTML;6753;125138;52719;1679657
JSP;2;1;0;46
Java;69;1032;738;3233
Javascript;93;1961;2799;11088
SQL;418;25707;62173;362137
Visual Basic;3;3;0;69
XML;29;115;144;1640
''';

  group("Count Java", () {
    test("report OK", () {
      expect(str1, equals(expected));
      expect(str2, equals(expected));
    });
  });
}

void main() {
  doTest();
}
