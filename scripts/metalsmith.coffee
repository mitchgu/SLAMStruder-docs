Metalsmith = require('metalsmith')
markdown = require('metalsmith-markdown')
layouts = require('metalsmith-layouts')
watch = require('metalsmith-watch')
serve = require('metalsmith-serve')
sass = require('metalsmith-sass')
ignore = require('metalsmith-ignore')
cleanCSS = require('metalsmith-clean-css')
moveUp = require('metalsmith-move-up')
partials = require('metalsmith-register-partials')
collections = require('metalsmith-collections')
permalinks = require('metalsmith-permalinks')
paths = require('metalsmith-paths')
redirect = require('metalsmith-redirect')
jade = require('metalsmith-jade')

exports.metalsmith = ->
  metalsmith = Metalsmith(__dirname)
    .concurrency(100)
    .source('../src')
    .destination('../build')
    .metadata(
      site:
        title: 'SLAMStruder Documentation'
        url: 'http://slamstruder.mitchgu.com')
    .use(sass(outputDir: 'assets/css/'))
    .use(ignore([ '**/sass/*.sass', '**/scss/*.scss' ]))
    .use(cleanCSS(files: '**/*.css'))
    .use(partials(directory: '../layouts/partials'))
    .use(moveUp([ 'content/**/*' ]))
    .use(paths())
    .use(collections(
      guides:
        pattern: 'guides/*.md'
        sortBy: 'order'
      technicals:
        pattern: 'technicals/*.md'
        sortBy: 'order'
      sources:
        pattern: 'sources/*.md'
        sortBy: 'order'))
    .use(markdown())
    .use(jade())
    .use(layouts(
      engine: 'jade'
      directory: '../layouts'))
    .use(permalinks(relative: false))
    .use(redirect(
      '/guides': '/guides/intro'
      '/technicals': '/technicals/testtechnical'
      '/sources': '/sources/testsource'))

exports.build = (callback) ->
  exports.metalsmith()
    .build (err, files) ->
      if err
        throw err
      if callback
        callback err, files

exports.server = (callback) ->
  exports.metalsmith()
    .use(serve())
    .use(watch(
      paths:
        '../src/**/*' : true,
        "../layouts/**/*": "**/*.md"
      livereload: true))
    .build (err, files) ->
      if err
        console.error err, err.stack
      if callback
        callback err, files
