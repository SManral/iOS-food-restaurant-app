var mongoose = require('mongoose');
var UserSchema = new mongoose.Schema({
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
	firstname: {
		type: String
	},
	lastname : String,
	phone : String,
	password : String
})
module.exports = mongoose.model('User', UserSchema);