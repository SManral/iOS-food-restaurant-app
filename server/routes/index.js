var express = require('express');
var router = express.Router();


var braintree = require("braintree");

var gateway = braintree.connect({
    environment:  braintree.Environment.Sandbox,
    merchantId:   'x9qzp7jc88h4bjt3',
    publicKey:    'fkv8qvsfck8y7k2w',
    privateKey:   '0e88d601367bbc73e5698d048b31f6bc'
});

/*
Generates tokens for braintree api
*/
router.get('/', function(req, res, next) {
  gateway.clientToken.generate({}, function (err, response) {
    res.send(response.clientToken);
  });
});

/*
Simulates a transaction for testing purposes
*/
router.post("/checkouts", function (req, res) {
  //var nonceFromTheClient = req.body.payment_method_nonce;

  gateway.transaction.sale({
  amount: "10.00",
  paymentMethodNonce: "fake-valid-nonce",
  options: {
    submitForSettlement: true
  }
  }, function (err, result) {
    res.send("server response");
  });
});

module.exports = router;
