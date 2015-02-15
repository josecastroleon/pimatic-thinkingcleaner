$(document).on( "templateinit", (event) ->
  class ThinkingCleanerDeviceItem extends pimatic.DeviceItem
    constructor: (templData, @device) ->
      super(templData, @device)

    afterRender: (elements) ->
      super(elements)
      # find the buttons
      @cleanButton = $(elements).find('[name=cleanButton]')
      @maxButton = $(elements).find('[name=maxButton]')
      @spotButton = $(elements).find('[name=spotButton]')
      @dockButton = $(elements).find('[name=dockButton]')
      @findmeButton = $(elements).find('[name=findmeButton]')
      @offButton = $(elements).find('[name=offButton]')
      return

    # define the available actions for the template
    cleanMode: -> @sendCommand "clean"
    maxMode: -> @sendCommand "max"
    spotMode: -> @sendCommand "spot"
    dockMode: -> @sendCommand "dock"
    findmeMode: -> @sendCommand "find_me"
    offMode: -> @sendCommand "poweroff"

    sendCommand: (command) ->
      @device.rest.sendCommand({command}, global: no)
        .done(ajaxShowToast)
        .fail(ajaxAlertFail)

    getConfig: (name) ->
      if @device.config[name]?
        return @device.config[name]
      else
        return @device.configDefaults[name]
      
  # register the item-class
  pimatic.templateClasses['ThinkingCleanerDevice'] = ThinkingCleanerDeviceItem
)
