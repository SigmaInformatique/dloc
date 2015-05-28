# Dart lines of code

## Overview

DLOC is a Dart program to count blank lines, comment lines and physical lines of source code.

```
prompt> dart dloc.dart $DLOC_HOME
LOC computation started...

files,language,blank,comment,code
1,Java,6,13,16
1,JSP,8,12,4
1,HTML,3,5,10
1,SQL,3,4,3
1,Visual Basic,0,3,1
1,Progress,15,26,24
1,Uniface,5,1,14
1,Bourne Again Shell,6,2,16
1,Bourne Shell,6,2,16
1,Delphi,10,29,12
1,XML,6,13,7
10,Dart,206,2868,5276

LOC computation done in: 447 ms
```

## License

DLOC is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

This software contains third party components. Please, see the [LICENSE](https://github.com/SigmaInformatique/dloc/blob/master/LICENSE) file for details.

## Options

```
prompt> pub run dloc

-r, --recursive           Recurse into sub-directories
                          (defaults to on)

-S, --follow-links        Recurse into links to directories
    --encoding            The encoding used (do not specify if unknown)
                          [utf8, latin1]

    --match-d             Only count files in directories matching the regex
    --not-match-d         Count all files except those in directories matching the regex
    --match-f             Only count files whose basenames match the regex
    --not-match-f         Count all files except those whose basenames match the regex
    --report-file         Write the results to <file> file instead of STDOUT
    --by-file             Report results for every source file encountered
    --by-file-by-lang     Report results for every source file encountered in addition to reporting by language
    --by-lang             Report results by language
                          (defaults to on)

    --print-cmd-detail    Print details about command args
                          (defaults to on)

    --sum-reports         Makes a cumulative set of results containing the sum of data from the individual report files
    --show-lang           Print information about all known languages and exit
```

## Recognized Languages

```
prompt> pub run dloc --show-lang

Java                  (.java)
JSP                   (.jsp)
Javascript            (.js)
HTML                  (.htm,.html)
SQL                   (.psql,.SQL,.sql,.pkb,.pks,.pls)
Visual Basic          (.bas,.cls,.ctl,.dsr,.frm,.vb,.VB,.vba,.VBA,.vbs,.VBS)
ASP                   (.asa,.asp)
ASP.Net               (.asax,.ascx,.asmx,.aspx,.config,.master,.sitemap,.webinfo)
Delphi Forms          (.dfm,.nfm)
Progress              (.P,.p,.I,.I[0-9]{2},.F,.adm,.fd)
Uniface               (.cptlst,.menlst,.prclst)
Jasper XML            (.jrxml)
Bourne Again Shell    .bash
Bourne Shell          (.sh)
DOS Batch             (.bat,.BAT,.cmd,.CMD)
Talend items          (.item)
C#                    (.cs)
Delphi                (.dpr,.pas)
Groovy                (.gant,.groovy)
GSP                   (.gsp)
XML                   (.xml,.XML)
COBOL                 (.cbl,.CBL,.cob,.COB)
Dart                  (.dart)
```

## How to run

### Using Dart SDK

1. Install (ie unzip) the [Dart SDK runtime](https://www.dartlang.org/downloads/)
1. Add the `bin` directory to your path (optional, or use the fully qualified path to the dart exe)
1. Download the [DLOC source code](https://github.com/SigmaInformatique/dloc) from GitHub
1. From the dloc directory, issue the following commands:
  1. `prompt> pub get` to download the dependencies
  1. `prompt> pub run dloc my_root_dir` to run the program (`pub run dloc` lists the available options)

### Using docker

TODO

## Found a bug?

Please, use the [GitHub issues](https://github.com/SigmaInformatique/dloc/issues).
