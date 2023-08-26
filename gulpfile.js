const gulp = require('gulp');
const minifyJs = require('gulp-minify');
const minifyCSS = require('gulp-clean-css');
const minifySelectors = require('gulp-minify-selectors');
const htmlmin = require('gulp-htmlmin');

gulp.task('minify-js', () => {
  return gulp.src('_site/**/*.js')
    .pipe(minifyJs({
      ext: {
        min:'.js'
      },
      noSource: true
    }))
    .pipe(gulp.dest('_site'));
});

gulp.task('minify-css', () => {
  return gulp.src('_site/**/*.css')
    .pipe(minifyCSS({ compatibility: 'ie8' }))
    .pipe(gulp.dest('_site'));
});

gulp.task('minify-html', () => {
  return gulp.src('_site/**/*.html')
    .pipe(htmlmin({ collapseWhitespace: true }))
    .pipe(gulp.dest('_site'));
});

gulp.task('default', gulp.parallel('minify-js', 'minify-css', 'minify-html'));
