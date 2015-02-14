module.exports = (env) ->

  Promise = env.require 'bluebird'
  assert = env.require 'cassert'

  request = require 'request'
  Promise.promisifyAll(request)

  class ThinkingCleanerPlugin extends env.plugins.Plugin

    init: (app, @framework, @config) =>
      deviceConfigDef = require("./device-config-schema")
      @framework.deviceManager.registerDeviceClass("ThinkingCleanerDevice", {
        configDef: deviceConfigDef.ThinkingCleanerDevice,
        createCallback: (config) -> new ThinkingCleanerDevice(config)
      })

      #wait till all plugins are loaded
      @framework.on "after init", =>
        # Check if the mobile-frontent was loaded and get a instance
        mobileFrontend = @framework.pluginManager.getPlugin 'mobile-frontend'
        if mobileFrontend?
          mobileFrontend.registerAssetFile 'js', "pimatic-thinkingcleaner/app/thinkingcleaner.coffee"
          mobileFrontend.registerAssetFile 'css', "pimatic-thinkingcleaner/app/css/thinkingcleaner.css"
          mobileFrontend.registerAssetFile 'html', "pimatic-thinkingcleaner/app/thinkingcleaner.html"
        else
          env.logger.warn "ThinkingCleaner could not find the mobile-frontend. No gui will be available"

  class ThinkingCleanerDevice extends env.devices.Device
    attributes:
      battery:
        description: "battery state"
        type: "number"
        discrete: true
        unit: "%"
      state:
        description: "state"
        type: "string"

    actions:
      sendCommand:
        params: 
          command: 
            type: "string"

    template: "ThinkingCleanerDevice"

    battery: 0
    state: "none"

    constructor: (@config) ->
      @id = @config.id
      @name = @config.name
      @host = @config.host
      @interval = @config.interval
      super()
      @readLoop    

    readLoop: =>
      setInterval( =>
        request 'http://"+@host+"/status.json', (error, response, body) =>
          if (!error && response.statusCode == 200)
            data = JSON.parse(body)
            _setState data.status.cleaner_state 
            _setBattery data.status.battery_charge
      , @interval)

    getBattery: () -> Promise.resolve(@battery)
    getState: () -> Promise.resolve(@state)

    _setBattery: (battery) ->
      @battery = battery
      @emit "battery", @battery

    _setState: (state) ->
      @state = state
      @emit "state", @state

    cleanPressed: () -> @sendCommand clean
    spotPressed: () -> @sendCommand spot
    maxCleanPressed: () -> @sendCommand max
    dockPressed: () -> @sendCommand dock

    sendCommand: (command) ->
      request "http://"+@host+"/command.json?command="+command, (error, response, body) =>
        if (!error && response.statusCode == 200) 
          data = JSON.parse(body)

  thinkingCleanerPlugin = new ThinkingCleanerPlugin
  return thinkingCleanerPlugin
