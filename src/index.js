require('./css/main.css');
require('./css/normalize.css');

var Elm = require('./Main.elm');
var root = document.getElementById('root');

Elm.Main.embed(root, logoPath);
