mongoose = require('mongoose');
var Restaurant = require('../datasets/restaurants');

module.exports.signup = function(req, res){
	req.body.username = req.body.username.toLowerCase();
	req.body.password = req.body.password.toLowerCase();
	console.log(req.body);
	Restaurant.find({
		'$or': [{username: req.body.username}, {password: req.body.password}]
	}, function(err, result){
		if(result.length === 0) {
			var restaurant = new Restaurant(req.body);
			restaurant.save();
			var restaurantData = {
				username : req.body.username,
				email: req.body.email,
				_id: restaurant._id,
				name: req.body.name
			}
			console.log(restaurantData);
			res.json({res: 'success', data: restaurantData});	
		}
		else {
			res.json({res: 'error', error: err});	
		}
	})
}

module.exports.login = function(req, res){
	req.body.username = req.body.username.toLowerCase();
	req.body.password = req.body.password.toLowerCase();
	Restaurant.find({
		'$and': [{username:req.body.username},{password:req.body.password}]
	}, function(err, success){
		if(success && success.length == 1){
			var restaurant = success[0];
			var restaurantData = {
				username: restaurant.username,
				firstname: restaurant.firstname,
				_id: restaurant._id,
				lastname: restaurant.lastname
			}
			console.log(restaurantData);
			res.json({res: "success", data: restaurantData});
		}
		else {
			res.json({res: 'error', data:'Login or password are wrong'});
		}
	})
}