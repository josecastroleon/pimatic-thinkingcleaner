module.exports = (env) ->

  Promise = env.require 'bluebird'
  assert = env.require 'cassert'

  class ThinkingCleaner extends env.plugins.Plugin

    init: (app, @framework, @config) =>
      env.logger.info("Hello World")

  thinkingCleaner = new ThinkingCleaner
  return thinkingCleaner
