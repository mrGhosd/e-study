var _            = require('lodash');
var browserify   = require('browserify');
var browserSync  = require('browser-sync');
var config       = require('./config').browserify;
var gulp         = require('gulp');
var source       = require('vinyl-source-stream');
var watchify     = require('watchify');

var browserifyTask = function(){

};

gulp.task('browserify', browserifyTask);
module.exports = browserifyTask;