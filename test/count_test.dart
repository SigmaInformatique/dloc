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
import 'package:args/args.dart';
import 'package:dloc/dloc_base.dart';

Lang _getLangFromDesc(String desc) {
  for (Lang each in langs) {
    if (each.desc == desc) {
      return each;
    }
  }
  return null;
}

void doTest() {
  List<String> arguments = ['--' + MATCH_DIR, '/test/data/lang'];
  ArgResults argResults = parser.parse(arguments);

  initialize(new CommandLineArgs(argResults));

  LocResult results = countLinesOfCode('${Directory.current.path}/data/lang');

  ResultByLang javaResults = results.data[_getLangFromDesc(JAVA_DESC).ext];
  group("Count Java", () {
    test("lines OK", () {
      expect(javaResults.lines, equals(16));
    });
    test("comments OK", () {
      expect(javaResults.comments, equals(13));
    });
    test("blanks OK", () {
      expect(javaResults.blanks, equals(6));
    });
  });

  ResultByLang delphiResults = results.data[_getLangFromDesc(DELPHI_DESC).ext];
  group("Count Delphi", () {
    test("lines OK", () {
      expect(delphiResults.lines, equals(12));
    });
    test("comments OK", () {
      expect(delphiResults.comments, equals(29));
    });
    test("blanks OK", () {
      expect(delphiResults.blanks, equals(10));
    });
  });

  ResultByLang progressResults = results.data[_getLangFromDesc(PROGRESS_DESC).ext];
  group("Count Progress", () {
    test("lines OK", () {
      expect(progressResults.lines, equals(24));
    });
    test("comments OK", () {
      expect(progressResults.comments, equals(26));
    });
    test("blanks OK", () {
      expect(progressResults.blanks, equals(15));
    });
  });

  ResultByLang htmlResults = results.data[_getLangFromDesc(HTML_DESC).ext];
  group("Count HTML", () {
    test("lines OK", () {
      expect(htmlResults.lines, equals(10));
    });
    test("comments OK", () {
      expect(htmlResults.comments, equals(5));
    });
    test("blanks OK", () {
      expect(htmlResults.blanks, equals(3));
    });
  });

  ResultByLang xmlResults = results.data[_getLangFromDesc(XML_DESC).ext];
  group("Count XML", () {
    test("lines OK", () {
      expect(xmlResults.lines, equals(7));
    });
    test("comments OK", () {
      expect(xmlResults.comments, equals(13));
    });
    test("blanks OK", () {
      expect(xmlResults.blanks, equals(6));
    });
  });

  ResultByLang unifaceResults = results.data[_getLangFromDesc(UNIFACE_DESC).ext];
  group("Count Uniface", () {
    test("lines OK", () {
      expect(unifaceResults.lines, equals(14));
    });
    test("comments OK", () {
      expect(unifaceResults.comments, equals(1));
    });
    test("blanks OK", () {
      expect(unifaceResults.blanks, equals(5));
    });
  });

  ResultByLang sqlResults = results.data[_getLangFromDesc(SQL_DESC).ext];
  group("Count SQL", () {
    test("lines OK", () {
      expect(sqlResults.lines, equals(3));
    });
    test("comments OK", () {
      expect(sqlResults.comments, equals(4));
    });
    test("blanks OK", () {
      expect(sqlResults.blanks, equals(3));
    });
  });

  ResultByLang bashResults = results.data[_getLangFromDesc(BASH_DESC).ext];
  group("Count BASH", () {
    test("lines OK", () {
      expect(bashResults.lines, equals(16));
    });
    test("comments OK", () {
      expect(bashResults.comments, equals(2));
    });
    test("blanks OK", () {
      expect(bashResults.blanks, equals(6));
    });
  });

  ResultByLang shResults = results.data[_getLangFromDesc(SH_DESC).ext];
  group("Count SH", () {
    test("lines OK", () {
      expect(shResults.lines, equals(16));
    });
    test("comments OK", () {
      expect(shResults.comments, equals(2));
    });
    test("blanks OK", () {
      expect(shResults.blanks, equals(6));
    });
  });
}

void main() {
  doTest();
}
