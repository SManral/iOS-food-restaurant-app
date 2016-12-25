var mongoose = require('mongoose');
var Restaurant = require('../datasets/restaurants');
var Menu = require('../datasets/food_menu');
ObjectId = mongoose.Types.ObjectId;

module.exports.addmenu = function(req, res){
	console.log(req.body);
	for(var i= 0; i< req.body.length; i++) {
		var restaurant = new Menu(req.body[i]);
		restaurant.save();
		var restaurantData = {
		restID : req.body[i].restID,
		itemName: req.body[i].itemName,
		subType: req.body[i].subType,
		cuisine: req.body[i].cuisine, 
		description: req.body[i].description,
		_id: restaurant._id,
		duration: req.body[i].duration,
		quantity: req.body[i].quantity,
		unit: req.body[i].unit,
		cost: req.body[i].cost,
	}
	console.log(restaurantData);

	}
	
	res.json({res: 'success', data: restaurantData});	

}
module.exports.removemenu = function(req, res) {
	var menuId = req.body.itemId;
	Menu.find({}, function(err, results){
		results.map(function(menu, index){
			if(menu._id == menuId) {
				results.splice(index, 1);
			}
			menu.save();
		})
		res.json({res: 'success', data: results});

	})
}


module.exports.get = function(req, res) {
	var idRest = req.body._id;
	Restaurant.findById(idRest, function(err, restaurant){
		if(err) {
			console.log(err);
		} else {
			Menu.find({restID : idRest}, function(err, menus){
				var obj = {
					restuarant : restaurant,
					menus : menus
				}
				
				res.json({res: 'success', data: obj});
			})
		}
	})
}

module.exports.search = function(req, res){
	Restaurant.find({
		'$and': [{city:req.body.city},{state:req.body.state}]
	}, function(err, success){
		var idsRes = [];
		var restNames = [];
		for(var i = 0; i< success.length; i++) {
			idsRes.push(mongoose.Types.ObjectId(success[i]._id));
			var obj = {
				id: mongoose.Types.ObjectId(success[i]._id),
				name : success[i].name
			}
			restNames.push(obj);
		}
		Menu.find({
	    'restID': { $in: idsRes}
	}, function(err, docs){
		Restaurant.find({
			'_id' : { $in : idsRes}
		}, function(err, rest){
			var menuResults = docs.map(function(doc){
				for(var i =0; i< rest.length; i++) {
					if(doc.restID == rest[i]._id){
						var menuData = {
							restID : doc.restID,
							restName : rest[i].name,
							itemName : doc.itemName,
							subType : doc.subType,
							cuisine : doc.cuisine,
							description : doc.description,
							duration : doc.duration,
							quantity : doc.quantity,
							unit : doc.unit,
							cost : doc.cost
						}
						return menuData;
					}
				}
			})
			res.json({res: 'success', data: menuResults});
		})
		
	     
		});
	});
}