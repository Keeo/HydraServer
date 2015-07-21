/* global require, module */
var EmberApp = require('ember-cli/lib/broccoli/ember-app');

module.exports = function(defaults) {
  var app = new EmberApp(defaults, {
    // Add options here
  });

  // https://bootswatch.com/darkly/
  app.import('bower_components/bootswatch-dist/css/bootstrap.css');
  app.import('bower_components/smoothie/smoothie.js');

  return app.toTree();
};
