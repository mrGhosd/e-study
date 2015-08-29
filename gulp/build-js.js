var _            = require('lodash');
var browserify   = require('browserify');
var browserSync  = require('browser-sync');
var config       = require('./config').browserify;
var gulp         = require('gulp');
var source       = require('vinyl-source-stream');
var watchify     = require('watchify');
var uglify       = require('gulp-uglify');

var browserifyTask = function(){
    var browserifyThis = function(bundleConfig) {
        var b = browserify(bundleConfig);
        var bundle = function() {
            return b
                .bundle()
                .pipe(source(bundleConfig.outputName))
                .pipe(gulp.dest(bundleConfig.dest))
                .pipe(browserSync.reload({stream:true}));
        };
        return bundle();
    };
    config.bundleConfigs.forEach(browserifyThis);
};

gulp.task('browserify', browserifyTask);
module.exports = browserifyTask;