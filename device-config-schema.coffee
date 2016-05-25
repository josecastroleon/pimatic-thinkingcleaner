module.exports = {
  title: "Thinking Cleaner device config schemas"
  ThinkingCleanerDevice: {
    title: "ThinkingCleaner config options"
    type: "object"
    properties:
      host:
        description: "IP address of the device"
        type: "string"
      port:
        description: "Service port"
        type: "number"
        default: 80
      interval:
        description: "Interval between read requests"
        type: "number"
        default: 10000
  }
}
