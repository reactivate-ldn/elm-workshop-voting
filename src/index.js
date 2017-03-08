require('./css/sanitize.css');
require('./css/main.css');

var Elm = require('./Main.elm');
var root = document.getElementById('root');

Elm.Main.embed(root);
