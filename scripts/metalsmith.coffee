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
    .use(collections(
      guides:
        pattern: 'guide/*.md'
        sortBy: 'order'
      details:
        pattern: 'detail/*.md'
        sortBy: 'order'
      makes:
        pattern: 'make/:section/*'
        sortBy: 'order',
        orderDynamicCollections: [
          'intro',
          'hardware',
          'electronics',
          'software'
        ]))
    .use(markdown())
    .use(jade())
    .use(permalinks(relative: false))
    .use(layouts(
      engine: 'jade'
      directory: '../layouts'))
    .use(redirect(
      '/guides': '/guide/intro'
      '/make': '/make/intro/start'
      '/make/intro': '/make/intro/start'
      '/make/hardware': '/make/hardware/intro'
      '/make/electronics': '/make/electronics/intro'
      '/make/software': '/make/software/intro'
      '/details': '/detail/overview'))

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
