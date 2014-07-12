# GULP-FILE --------------------------------------------------------------------

gulp        = require 'gulp'
gutil       = require 'gulp-util'
sass        = require 'gulp-sass'
browserSync = require 'browser-sync'
browserify  = require 'gulp-browserify'
coffeelint  = require 'gulp-coffeelint'
rename      = require 'gulp-rename'
uglify      = require 'gulp-uglify'
rimraf      = require 'gulp-rimraf'
runSequence = require 'run-sequence'

# CONFIG -----------------------------------------------------------------------

isRelease = gutil.env.type is 'release'

sources =
  sass:   'sass/**/*.scss'
  html:   'index.html'
  coffee: 'src/**/*.coffee'

destinations =
  css:  'dist/css'
  html: 'dist/'
  js:   'dist/js'

# TASKS ------------------------------------------------------------------------

gulp.task 'browser-sync', ->
  browserSync.init [
    'dist/*.html'
    'dist/**/*.js'
    'dist/**/*.css'
    ],
    server:
      baseDir: './dist'

gulp.task 'style', ->
  gulp.src(sources.sass)
  .pipe(sass(outputStyle: 'compressed', errLogToConsole: true))
  .pipe(rename('app.min.css'))
  .pipe(gulp.dest(destinations.css))

gulp.task 'html', ->
  gulp.src(sources.html)
  .pipe(gulp.dest(destinations.html))

gulp.task 'lint', ->
  gulp.src(sources.coffee)
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())

gulp.task 'src', ->
  gulp.src(sources.coffee, read: false)
  .pipe(browserify
    transform:  ['coffeeify'],
    extensions: ['.coffee'],
    insertGlobals: true,
    debug: not isRelease)
  .pipe(rename('app.min.js'))
  .pipe(gulp.dest(destinations.js))

gulp.task 'watch', ->
  gulp.watch sources.sass,   ['style']
  gulp.watch sources.coffee, ['lint', 'src', 'html']
  gulp.watch sources.html,   ['html']

gulp.task 'clean', ->
  gulp.src(['dist/'], read: false).pipe(rimraf())

gulp.task 'build', ->
  runSequence 'clean', ['style', 'lint', 'src', 'html']

gulp.task 'build:watch', ['build', 'browser-sync', 'watch']

gulp.task 'default', ['build']
