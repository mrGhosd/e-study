var requireDir = require('require-dir');

// Require all tasks in gulp/tasks, including subfolders
//requireDir('./gulp', { recurse: true });
var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');

gulp.task('scripts', function () {
    gulp.src(['app/assets/javascripts/**/*.js'])
        .pipe(concat('scripts.js'))
        .pipe(gulp.dest('public/assets/javascripts'));
});
gulp.task('copy-bower-components', function () {
    gulp.src('./vendor/assets/bower_components/**')
        .pipe(gulp.dest('public/assets/javascripts/bower_components'));
});