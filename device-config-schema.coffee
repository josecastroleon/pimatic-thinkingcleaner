module.exports = {
  title: "Thinking Cleaner device config schemas"
  ThinkingCleanerDevice: {
    title: "ThinkingCleaner config options"
    type: "object"
    properties:
      host:
        description: "IP address of the device"
        default: "192.168.1.3"
      interval:
        description: "Interval between read requests"
        format: "number"
        default: 10000
  }
}
