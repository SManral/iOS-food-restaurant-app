var express = require('express');
var mongoose = require('mongoose');
var bodyParser = require('body-parser');

var app = express();
var authenticationController = require('./server/controllers/authentication_Controller');
var authenticationRestController = require('./server/controllers/authentication_Rest_Controller');
var restaurantMenuController = require('./server/controllers/restaurant_Menu_Controller');

mongoose.connect('mongodb://localhost:27017/portfolio2db');

app.use(bodyParser.json());
app.use('/app', express.static(__dirname + "/app"));
app.use('/node_modules', express.static(__dirname + "/node_modules"));

//Authentication for users
app.post('/api/user/signup', authenticationController.signup);
app.post('/api/user/login', authenticationController.login);
app.get('/testUri', authenticationController.loginFromApp);

//Authentication for restaurants
app.post('/api/restaurant/signup', authenticationRestController.signup);
app.post('/api/restaurant/login', authenticationRestController.login);
app.post('/api/restaurant/addmenu', restaurantMenuController.addmenu);
app.post('/api/restaurant/removemenu', restaurantMenuController.removemenu);
app.post('/api/restaurant/search', restaurantMenuController.search);
app.post('/api/restaurant/get', restaurantMenuController.get);

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});



app.get('/', function(req, res){
	res.sendfile('index.html');
})
app.listen('3000', function(){
	console.log('Server working');
})