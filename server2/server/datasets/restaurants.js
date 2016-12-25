var mongoose = require('mongoose');
var RestaurantSchema = new mongoose.Schema({
	username: {
    type: String,
    index: { 
    	unique: true 
    },
    required: true
  },
	email: {
		type: String
	},
	name: {
		type: String
	},
	phone : String,
	password : String,
	street : String,
	city : String,
	state : String

})
module.exports = mongoose.model('Restaurant', RestaurantSchema);