
var http = require('https');
var fs = require('fs');
var path = require('path');

var option = {
    key: fs.readFileSync('/etc/ssl/node/static_cert.key'),
    cert: fs.readFileSync('/etc/ssl/node/static_cert.crt'),
}

http.createServer(option, function(req, res){
    if (req.url === '/') {
        // Lecture du fichier HTML
        var filePath = path.join(__dirname, '../var/www/html/index.html');
        var stat = fs.statSync(filePath);

        res.writeHead(200, {
            'Content-Type': 'text/html',
            'Content-Length': stat.size
        });

        var readStream = fs.createReadStream(filePath);
        readStream.pipe(res);
    } else {
        // Autres routes, renvoie une erreur 404 par exemple
        res.writeHead(404, {'Content-Type': 'text/plain'});
        res.end('Not Found\n');
    }
}).listen(4242, '0.0.0.0');