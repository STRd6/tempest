// Generated by CoffeeScript 1.6.3
(function() {
  var HAMLjr, Tempest, compile, parser, util, _ref;

  _ref = HAMLjr = require('haml-jr'), parser = _ref.parser, compile = _ref.compile, util = _ref.util;

  Tempest = require('./tempest');

  Object.extend(window, Tempest);

  window.styl = require('styl');

  window.HAMLjr = HAMLjr;

  window.parser = parser;

  window.Gistquire = require('./gistquire');

}).call(this);
