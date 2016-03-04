yaml        = require('js-yaml')
fs          = require('fs')
path        = require('path')
Metalsmith  = require('metalsmith')
markdown    = require('metalsmith-markdown')
layouts     = require('metalsmith-layouts')
watch       = require('metalsmith-watch')
serve       = require('metalsmith-serve')
sass        = require('metalsmith-sass')
ignore      = require('metalsmith-ignore')
cleanCSS    = require('metalsmith-clean-css')
moveUp      = require('metalsmith-move-up')
partials    = require('metalsmith-register-partials')
collections = require('metalsmith-collections')
permalinks  = require('metalsmith-permalinks')
redirect    = require('metalsmith-redirect')
jade        = require('metalsmith-jade')

try
  config = yaml.safeLoad(fs.readFileSync(path.resolve(__dirname, 'config.yaml'), 'utf8'))
catch e
  console.log e

exports.metalsmith = ->
  metalsmith = Metalsmith(__dirname)
    .concurrency(100)
    .source(config.source)
    .destination(config.destination)
    .metadata(config.metadata)
    .use(sass(config.sass))
    .use(ignore(config.ignore))
    .use(cleanCSS(config.cleanCSS))
    .use(partials(config.partials))
    .use(moveUp(config.moveUp))
    .use(collections(config.collections))
    .use(markdown())
    .use(jade())
    .use(permalinks(config.permalinks))
    .use(layouts(config.layouts))
    .use(redirect(config.redirects))

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
    .use(watch(config.watch))
    .build (err, files) ->
      if err
        console.error err, err.stack
      if callback
        callback err, files
