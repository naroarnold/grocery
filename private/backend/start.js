#!/usr/bin/env node

// This is a Node script picks between start.sh and start.bat to start Rserve
// Note: This has nothing to do with Meteor, despite being js.

var platform = require('platform');
var path = require('path');
var child_process = require('child_process');
var util = require('util');

var paths = {Win32: "start.bat", Linux:"start.sh"};
var family = platform.os.family;

if(family in paths) {
  var filename = path.resolve(__dirname, paths[family]);
  child_process.spawn(filename, [], {stdio:'inherit'});
} else {
  var fmt = "Can't start Rserve automatically on platform %s. From within R run:\n> source('%s');\n";
  var msg = util.format(fmt, family, path.resolve(__dirname, "mw", "setup.R"));
  process.stderr.write(msg);
}
