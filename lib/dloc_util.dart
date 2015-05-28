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

/// A simple set of utility methods functions.
library dloc.util;

import 'dart:io';

/// Returns the given [path] replacing all backward to forward slashes (also removing the trailing one, if any).
String toForwardSlash(String path, {removeLast: true}) {
  String str = path.replaceAll('\\', '/');
  if (str.endsWith('/')) {
    str = str.substring(0, str.length - 1);
  }
  return str;
}

/// Returns parent as String from a file system [entity].
String parent(FileSystemEntity entity) {
  return toForwardSlash(entity.parent.path);
}

/// Returns last segment from a file system [entity].
///
/// For example:
///     D:/NIO/dev/ -> dev
String lastSegment(FileSystemEntity entity) {
  String parent = toForwardSlash(entity.parent.path);
  return entity.path.substring(parent.length + 1);
}

///
/// Returns last segment from a [path] as string.
///
/// For example:
///     D:/NIO/dev/ -> dev
///
String lastSegmentFromString(String path) {
  path = toForwardSlash(path);
  int idx = path.lastIndexOf('/');
  return path.substring(idx + 1);
}

/// Creates the directory denoted by the 'dir' argument, if it doesn't exist.
bool createDirIfNotExists(String dir) {
  if (!new Directory(dir).existsSync()) {
    new Directory(dir).createSync(recursive: true);
    return true;
  }
  return false;
}

/// Deletes the file denoted by the 'dir' argument, if it doesn't exist.
void deleteFile(String filename) {
  if ((filename == null) || (!new File(filename).existsSync())) {
    return;
  }
  new File(filename).deleteSync();
}

/// Creates a backup for the file denoted by the 'dir' argument.
///
/// - [andDelete] to delete the file after backup creation
void backupFile(String filename, bool andDelete) {
  if ((filename == null) || (!new File(filename).existsSync())) {
    return;
  }
  DateTime now = new DateTime.now();
  new File(filename).copySync(filename + '.BAK@${now.millisecondsSinceEpoch}');
  if (andDelete) {
    new File(filename).deleteSync();
  }
}
