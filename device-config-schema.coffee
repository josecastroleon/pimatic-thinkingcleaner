module.exports = {
  title: "Thinking Cleaner device config schemas"
  ThinkingCleanerDevice: {
    title: "ThinkingCleaner config options"
    type: "object"
    properties:
      host:
        description: "IP address of the device"
        type: "string"
      interval:
        description: "Interval between read requests"
        type: "number"
        default: 10000
  }
}
