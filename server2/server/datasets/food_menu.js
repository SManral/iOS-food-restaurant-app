var mongoose = require('mongoose');
var MenuSchema = new mongoose.Schema({
  restID:String,
	itemName: {
    type: String,
    index: { 
    	unique: true 
    },
    required: true
  },
  	subType: String,
  	cuisine:String,
	description: String,
	duration: String,
	quantity : String,
	unit : String,
	cost : String
})
module.exports = mongoose.model('Menu', MenuSchema);