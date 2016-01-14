var express = require('express');
var app = express();
var port = 3000;
var status = "off";

app.all("*", function (req, res) {
    console.log("Request", req.url);

    var match = req.url.match(/command=([A-Za-z]+)/);
    if (match !== null) {
        status = match[1];
    }
    res.send(JSON.stringify({
        status: {
            cleaner_state: status,
            battery_charge: 60
        }
    }));
});

app.listen(port, function () {
    console.log('Roomba mockup listening on port ' + port);
});