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

//
// Language definitions as constants
//

const ASP = r'(.+\.asa$|.+\.asp$)';
const ASP_DESC = 'ASP';
const ASP_CMT_FROM = HTML_CMT_FROM;
const ASP_CMT_TO = HTML_CMT_TO;
const ASP_CMT_FROM2 = JSP_CMT_FROM2;
const ASP_CMT_TO2 = JSP_CMT_TO2;

const ASP_NET = r'(.+\.asax$|.+\.ascx$|.+\.asmx$|.+\.aspx$|.+\.config$|.+\.master$|.+\.sitemap$|.+\.webinfo$)';
const ASP_NET_DESC = 'ASP.Net';
const ASP_NET_CMT_FROM = HTML_CMT_FROM;
const ASP_NET_CMT_TO = HTML_CMT_TO;
const ASP_NET_CMT_FROM2 = JSP_CMT_FROM2;
const ASP_NET_CMT_TO2 = JSP_CMT_TO2;

const BASH = r'.+\.bash$';
const BASH_DESC = 'Bourne Again Shell';
const BASH_CMT_SINGLE = r'^\s*#';
const BASH_RM_MATCHES = r'^\s*#!';
//const BASH_RM_INLINE = r'#.*$';

const CSHARP = r'(.+\.cs$)';
const CSHARP_DESC = 'C#';
const CSHARP_CMT_SINGLE = JAVA_CMT_SINGLE;
const CSHARP_CMT_FROM = JAVA_CMT_FROM;
const CSHARP_CMT_TO = JAVA_CMT_TO;
const CSHARP_RM_INLINE = JAVA_RM_INLINE;

const COBOL = r'(.+\.cbl$|.+\.CBL$|.+\.cob$|.+\.COB$)';
const COBOL_DESC = 'COBOL';

const DELPHI = r'(.+\.dpr$|.+\.pas$)';
const DELPHI_DESC = 'Delphi';
const DELPHI_CMT_SINGLE = JAVA_CMT_SINGLE;
const DELPHI_CMT_FROM = r'(*';
const DELPHI_CMT_TO = r'*)';
const DELPHI_CMT_FROM2 = r'{';
const DELPHI_CMT_TO2 = r'}';

const DELPHI_FORM = r'(.+\.dfm$|.+\.nfm$)';
const DELPHI_FORM_DESC = 'Delphi Forms';

const DOS = r'(.+\.bat$|.+\.BAT$|.+\.cmd$|.+\.CMD$)';
const DOS_DESC = 'DOS Batch';
const DOS_CMT_SINGLE = r'^\s*rem';

const GROOVY = r'(.+\.gant$|.+\.groovy$)';
const GROOVY_DESC = 'Groovy';
const GROOVY_CMT_SINGLE = JAVA_CMT_SINGLE;
const GROOVY_CMT_FROM = JAVA_CMT_FROM;
const GROOVY_CMT_TO = JAVA_CMT_TO;
const GROOVY_RM_INLINE = JAVA_RM_INLINE;

const GSP = r'(.+\.gsp$)';
const GSP_DESC = 'GSP';
const GSP_CMT_FROM = HTML_CMT_FROM;
const GSP_CMT_TO = HTML_CMT_TO;
const GSP_CMT_FROM2 = JSP_CMT_FROM2;
const GSP_CMT_TO2 = JSP_CMT_TO2;
const GSP_CMT_FROM3 = r'%{--';
const GSP_CMT_TO3 = r'--}%';

const HTML = r'(.+\.htm$|.+\.html$)';
const HTML_DESC = 'HTML';
const HTML_CMT_FROM = r'<!--';
const HTML_CMT_TO = r'-->';

const JASPER = r'(.+\.jrxml$)';
const JASPER_DESC = 'Jasper XML';
const JASPER_CMT_FROM = HTML_CMT_FROM;
const JASPER_CMT_TO = HTML_CMT_TO;

const JAVA = r'(.+\.java$)';
const JAVA_DESC = 'Java';
const JAVA_CMT_SINGLE = r'^\s*//';
const JAVA_CMT_FROM = r'/*';
const JAVA_CMT_TO = r'*/';
const JAVA_RM_INLINE = r'//.*$';

const JS = r'(.+\.js$)';
const JS_DESC = 'Javascript';
const JS_CMT_SINGLE = JAVA_CMT_SINGLE;
const JS_CMT_FROM = JAVA_CMT_FROM;
const JS_CMT_TO = JAVA_CMT_TO;
const JS_RM_INLINE = JAVA_RM_INLINE;

const JSP = r'(.+\.jsp$)';
const JSP_DESC = 'JSP';
const JSP_CMT_SINGLE = JAVA_CMT_SINGLE;
const JSP_CMT_FROM = HTML_CMT_FROM;
const JSP_CMT_TO = HTML_CMT_TO;
const JSP_CMT_FROM2 = r'<%--';
const JSP_CMT_TO2 = r'--%>';

const PROGRESS = r'(.+\.P$|.+\.p$|.+\.I$|.+\.I[0-9]{2}$|.+\.F$|.+\.adm$|.+\.fd$)';
const PROGRESS_DESC = 'Progress';
const PROGRESS_CMT_SINGLE = r'^/\*.*\*/$';
const PROGRESS_CMT_FROM = JAVA_CMT_FROM;
const PROGRESS_CMT_TO = JAVA_CMT_TO;

const SH = r'(.+\.sh$)';
const SH_DESC = 'Bourne Shell';
const SH_CMT_SINGLE = r'^\s*#';
const SH_RM_MATCHES = r'^\s*#!';

const SQL = r'(.+\.psql$|.+\.SQL$|.+\.sql$|.+\.pkb$|.+\.pks$|.+\.pls$)';
const SQL_DESC = 'SQL';
const SQL_CMT_SINGLE = r'^\s*--';
const SQL_CMT_FROM = JAVA_CMT_FROM;
const SQL_CMT_TO = JAVA_CMT_TO;
//const SQL_RM_INLINE = r'--.*$';

const TALEND = r'(.+\.item$)';
const TALEND_DESC = 'Talend items';
const TALEND_CMT_SINGLE = r'^\s*<!--.*-->$';
const TALEND_CMT_FROM = HTML_CMT_FROM;
const TALEND_CMT_TO = HTML_CMT_TO;

const UNIFACE = r'(.+\.cptlst$|.+\.menlst$|.+\.prclst$)';
const UNIFACE_DESC = 'Uniface';
const UNIFACE_CMT_SINGLE = r'^\s*;\s';
const UNIFACE_RM_MATCHES = r'^\s*[^\[]';
const UNIFACE_MARGIN = 26;

const VB = r'(.+\.bas$|.+\.cls$|.+\.ctl$|.+\.dsr$|.+\.frm$|.+\.vb$|.+\.VB$|.+\.vba$|.+\.VBA$|.+\.vbs$|.+\.VBS$)';
const VB_DESC = 'Visual Basic';
const VB_CMT_SINGLE = r"^\s*'\s";

const XML = r'(.+\.xml$|.+\.XML$)';
const XML_DESC = 'XML';
const XML_CMT_FROM = HTML_CMT_FROM;
const XML_CMT_TO = HTML_CMT_TO;

const DART = r'(.+\.dart)';
const DART_DESC = 'Dart';
const DART_CMT_SINGLE = JAVA_CMT_SINGLE;
const DART_CMT_FROM = JAVA_CMT_FROM;
const DART_CMT_TO = JAVA_CMT_TO;
const DART_RM_INLINE = JAVA_RM_INLINE;

/// Static information relative to a single language.
class Lang {
  /// Language file extension.
  RegExp ext;
  /// Language human readable description.
  String desc;
  /// Language single line comment.
  RegExp cmtSingle;
  /// Language multi line comment start.
  List<String> cmtMultiStarts;
  /// Language multi line comment end.
  List<String> cmtMultiEnds;
  // In order to ignore portions inside a line.
  RegExp rmInline;
  // In order to ignore full lines.
  RegExp rmMatches;
  /// Some languages use a margin.
  int marginLgth;

  Lang(String ext, this.desc, String cmtSingle) {
    this.ext = new RegExp(ext);
    if (cmtSingle != null) {
      this.cmtSingle = new RegExp(cmtSingle);
    }
  }

  Lang.noSingle(String ext, this.desc) {
    this.ext = new RegExp(ext);
  }

  void withMulti(String cmtMultiStart, String cmtMultiEnd) {
    if (cmtMultiStart == null || cmtMultiEnd == null) {
      throw 'Illegal arguments for multiline comment.';
    }
    if (cmtMultiStarts == null) {
      cmtMultiStarts = [];
    }
    if (cmtMultiEnds == null) {
      cmtMultiEnds = [];
    }
    this.cmtMultiStarts.add(cmtMultiStart);
    this.cmtMultiEnds.add(cmtMultiEnd);
  }

  void withMargin(int marginLgth) {
    this.marginLgth = marginLgth;
  }

  void withRmInline(String rmInline) {
    if (rmInline != null) {
      this.rmInline = new RegExp(rmInline);
    }
  }

  void withRmMatches(String rmMatches) {
    if (rmMatches != null) {
      this.rmMatches = new RegExp(rmMatches);
    }
  }
}

// The list of all processed languages
final List langs = [
  new Lang(JAVA, JAVA_DESC, JAVA_CMT_SINGLE)
    ..withMulti(JAVA_CMT_FROM, JAVA_CMT_TO)
    ..withRmInline(JAVA_RM_INLINE), //
  new Lang(JSP, JSP_DESC, JSP_CMT_SINGLE)
    ..withMulti(JSP_CMT_FROM, JSP_CMT_TO)
    ..withMulti(JSP_CMT_FROM2, JSP_CMT_TO2), //
  new Lang(JS, JS_DESC, JS_CMT_SINGLE)
    ..withMulti(JS_CMT_FROM, JS_CMT_TO)
    ..withRmInline(JS_RM_INLINE), //
  new Lang.noSingle(HTML, HTML_DESC)..withMulti(HTML_CMT_FROM, HTML_CMT_TO), //
  new Lang(SQL, SQL_DESC, SQL_CMT_SINGLE)..withMulti(SQL_CMT_FROM, SQL_CMT_TO), //
  new Lang(VB, VB_DESC, VB_CMT_SINGLE), //
  new Lang.noSingle(ASP, ASP_DESC)
    ..withMulti(ASP_CMT_FROM, ASP_CMT_TO)
    ..withMulti(ASP_CMT_FROM2, ASP_CMT_TO2), //
  new Lang.noSingle(ASP_NET, ASP_NET_DESC)
    ..withMulti(ASP_NET_CMT_FROM, ASP_NET_CMT_TO)
    ..withMulti(ASP_NET_CMT_FROM2, ASP_NET_CMT_TO2), //
  new Lang.noSingle(DELPHI_FORM, DELPHI_FORM_DESC), //
  new Lang(PROGRESS, PROGRESS_DESC, PROGRESS_CMT_SINGLE)..withMulti(PROGRESS_CMT_FROM, PROGRESS_CMT_TO), //
  new Lang(UNIFACE, UNIFACE_DESC, UNIFACE_CMT_SINGLE)
    ..withRmMatches(UNIFACE_RM_MATCHES)
    ..withMargin(UNIFACE_MARGIN), //
  new Lang.noSingle(JASPER, JASPER_DESC)..withMulti(JASPER_CMT_FROM, JASPER_CMT_TO), //
  new Lang(BASH, BASH_DESC, BASH_CMT_SINGLE)..withRmMatches(BASH_RM_MATCHES), //
  new Lang(SH, SH_DESC, SH_CMT_SINGLE)..withRmMatches(SH_RM_MATCHES), //
  new Lang(DOS, DOS_DESC, DOS_CMT_SINGLE), //
  new Lang(TALEND, TALEND_DESC, TALEND_CMT_SINGLE)..withMulti(TALEND_CMT_FROM, TALEND_CMT_TO), //
  new Lang(CSHARP, CSHARP_DESC, CSHARP_CMT_SINGLE)
    ..withMulti(CSHARP_CMT_FROM, CSHARP_CMT_TO)
    ..withRmInline(CSHARP_RM_INLINE), //
  new Lang(DELPHI, DELPHI_DESC, DELPHI_CMT_SINGLE)
    ..withMulti(DELPHI_CMT_FROM, DELPHI_CMT_TO)
    ..withMulti(DELPHI_CMT_FROM2, DELPHI_CMT_TO2), //
  new Lang(GROOVY, GROOVY_DESC, GROOVY_CMT_SINGLE)
    ..withMulti(GROOVY_CMT_FROM, GROOVY_CMT_TO)
    ..withRmInline(GROOVY_RM_INLINE), //
  new Lang.noSingle(GSP, GSP_DESC)
    ..withMulti(GSP_CMT_FROM, GSP_CMT_TO)
    ..withMulti(GSP_CMT_FROM2, GSP_CMT_TO2)
    ..withMulti(GSP_CMT_FROM3, GSP_CMT_TO3), //
  new Lang.noSingle(XML, XML_DESC)..withMulti(XML_CMT_FROM, XML_CMT_TO), //
  new Lang.noSingle(COBOL, COBOL_DESC), //
  new Lang(DART, DART_DESC, DART_CMT_SINGLE)
    ..withMulti(DART_CMT_FROM, DART_CMT_TO)
    ..withRmInline(DART_RM_INLINE)
];

/// Returns the lang object given a [filename], `null` otherwise.
Lang hasMatch(String filename) {
  for (Lang each in langs) {
    if (each.ext.hasMatch(filename)) {
      return each;
    }
  }
  return null;
}
