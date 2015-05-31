# Dart Lines Of Code

 - [Overview](#overview) 
 - [License & Copyright](#license) 
 - [How to install?](#install)
 - [How to use?](#use)
 - [How to use with Docker?](#docker)
 - [Available options](#option)
 - [Recognized Languages](#lang)
 - [Found a bug?](#bug)

## <a name="overview"></a> Overview

DLOC is a Dart program to count blank lines, comment lines and physical lines of source code. 
It is inspired by the [cloc](http://cloc.sourceforge.net/) Perl script.

Output example:

```
LOC computation started...

files     language                 blank     comment   code
1         Java                     6         13        16
1         JSP                      8         12        4
1         HTML                     3         5         10
1         SQL                      3         4         3
1         Visual Basic             0         3         1
1         Progress                 15        26        24
1         Uniface                  5         1         14
1         Bourne Again Shell       6         2         16
1         Bourne Shell             6         2         16
1         Delphi                   10        29        12
1         XML                      6         13        7
10        Dart                     213       2869      5331

LOC computation done in: 517 ms
```

## <a name="license"></a> License & Copyright

DLOC is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

Please, see the [LICENSE](https://github.com/SigmaInformatique/dloc/blob/master/LICENSE) file for details.

## <a name="install"></a> How to install?

Download the [Dart SDK](https://www.dartlang.org/downloads/) and unzip the ZIP file.

Put `dart-sdk/bin` in your PATH.

If you are behind a proxy, set the environment variables: `http_proxy`, `https_proxy`, and `no_proxy`.

Use the `pub global` command to install DLOC into your system.

```
pub global activate dloc
```

## <a name="use"></a> How to use?

If you have [modified your PATH](https://www.dartlang.org/tools/pub/cmd/pub-global.html#running-a-script-from-your-path), you can run DLOC from any local directory.

```
$ dloc /path/to/sources
```

Otherwise, you can use the `pub global` command.

```
$ pub global run dloc /path/to/sources
```

## <a name="docker"></a> How to use with Docker?

If [Docker](https://www.docker.com/) is already present on your system, you can immediately use [DLOC image](https://registry.hub.docker.com/u/sigmainformatique/dloc/) from Docker Hub. No installation is needed.

## <a name="option"></a> Available options

```
$ dloc
-r, --recursive           Recurse into sub-directories.
                          (defaults to on)

-S, --follow-links        Follow symbolic links.
    --encoding            The encoding to use (do not specify if unknown).
                          [utf8, latin1]

    --match-d             Only count files in directories matching the regex.
    --not-match-d         Count all files except those in directories matching the regex.
    --match-f             Only count files whose basenames match the regex.
    --not-match-f         Count all files except those whose basenames match the regex.
    --report-file         Write the results to <file> file instead of STDOUT.
    --by-file             Report results for every source file encountered.
    --by-file-by-lang     Report results for every source file encountered in addition to reporting by language.
    --print-cmd-detail    Print details about command arguments.
    --sum-reports         Makes a cumulative set of results containing the sum of data from the individual report files.
    --show-lang           Print information about all known languages and exit.
```

## <a name="lang"></a> Recognized Languages

```
$ dloc --show-lang

ASP                  (.asa,.asp)
ASP.Net              (.asax,.ascx,.asmx,.aspx,.config,.master,.sitemap,.webinfo)
Bourne Again Shell   .bash
Bourne Shell         (.sh)
C#                   (.cs)
COBOL                (.cbl,.CBL,.cob,.COB)
DOS Batch            (.bat,.BAT,.cmd,.CMD)
Dart                 (.dart)
Delphi               (.dpr,.pas)
Delphi Forms         (.dfm,.nfm)
GSP                  (.gsp)
Groovy               (.gant,.groovy)
HTML                 (.htm,.html)
JSP                  (.jsp)
Jasper XML           (.jrxml)
Java                 (.java)
Javascript           (.js)
Progress             (.P,.p,.I,.I[0-9]{2},.F,.adm,.fd)
SQL                  (.psql,.SQL,.sql,.pkb,.pks,.pls)
Talend items         (.item)
Uniface              (.cptlst,.menlst,.prclst)
Visual Basic         (.bas,.cls,.ctl,.dsr,.frm,.vb,.VB,.vba,.VBA,.vbs,.VBS)
XML                  (.xml,.XML)
```

## <a name="bug"></a> Found a bug?

Please, use the [GitHub issues](https://github.com/SigmaInformatique/dloc/issues).
