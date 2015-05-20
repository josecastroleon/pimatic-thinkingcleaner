pimatic-thinkingcleaner
=======================

A plugin for controlling a [thinkingcleaner](http://www.thinkingcleaner.com/) device in pimatic.

Configuration
-------------
Add the plugin to the plugin section:

    {
      "plugin": "thinkingcleaner"
    },

Then add the device into the devices section:

    {
      "id": "ThinkingCleaner",
      "name": "ThinkingCleaner",
      "class": "ThinkingCleanerDevice",
      "host": "192.168.1.3",
      "interval": 10000
    },

Then you can add the device into the mobile frontend
