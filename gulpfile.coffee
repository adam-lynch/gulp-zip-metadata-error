# ------------------------
# Dependencies
# -----------------------
global.gulp = require 'gulp'
global.$ = require('gulp-load-plugins')()

appName = 'TeamworkChat'


# ----------------------------------------
# Paths; all paths and globs used in tasks
# ----------------------------------------
global.paths = {}
paths.dist = {}
paths.dist.root = './dist/'
paths.dist.windows32 = paths.dist.root + appName + '/win32/**/**'

generateZipName = (appName, platform, version) -> appName + '_for_' + platform + '-' + version + '.zip'

pipes = {}
pipes.packageExecutable = (source, zipNameSegment, done) ->
    unless newVersionNumber
        newVersionNumber = require('./package.json').version

    gulp.src source
        .pipe $.zip generateZipName appName, zipNameSegment, newVersionNumber
        .pipe gulp.dest paths.dist.root
        .pipe $.size {showFiles: true}
        .on 'finish', done
    return

gulp.task 'default', (done) ->
    pipes.packageExecutable paths.dist.windows32, 'Windows32', done