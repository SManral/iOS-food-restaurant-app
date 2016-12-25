var mongoose = require('mongoose');
var User = require('../datasets/users');

module.exports.signup = function(req, res){
	req.body.username = req.body.username.toLowerCase();
	req.body.password = req.body.password.toLowerCase();
	var user = new User(req.body);
	user.save();
	res.json(req.body);	
	console.log(req.body);


	User.find({
		'$or': [{username: req.body.username}, {password: req.body.password}]
	}, function(err, result){
		if(result.length === 0) {
			var user = new User(req.body);
			user.save();
			var userData = {
				username : req.body.username,
				email: req.body.email,
				_id: user._id,
				firstname: req.body.firstname
			}
			console.log(userData);
			res.json({res: 'success', data: userData});	
		}
		else {
			res.json({res: 'error', error: err});	
		}
	})
}

module.exports.login = function(req, res){
	req.body.username = req.body.username.toLowerCase();
	req.body.password = req.body.password.toLowerCase();
	User.find({
		'$and': [{username:req.body.username},{password:req.body.password}]
	}, function(err, success){
		if(success && success.length == 1){
			var user = success[0];
			var userData = {
				username: user.username,
				firstname: user.firstname,
				_id: user._id,
				lastname: user.lastname
			}
			console.log(userData);
			res.json({res: "success", data: userData});
		}
		else {
			res.json({res: 'error', data:'Login or password are wrong'});
		}
	})
}

module.exports.loginFromApp = function(req, res){
	req.query.username = req.query.username.toLowerCase();
	req.query.password = req.query.password.toLowerCase();
	
	User.find({
		'$and': [{username:req.query.username},{password:req.query.password}]
	}, function(err, success){
		if(success && success.length == 1){
			var user = success[0];
			var userData = {
				username: user.username,
				firstname: user.firstname,
				_id: user._id,
				lastname: user.lastname
			}
			console.log(userData);
			res.json({res: "success", data: userData});
		}
		else {
			res.json({res: 'error', data:'Login or password are wrong'});
		}
	})
}