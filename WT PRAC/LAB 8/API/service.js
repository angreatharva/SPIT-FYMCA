function greeting(req, res) {
  var greet = req.query.firstname;
  res.send("Greetings, " + greet);
}

function additon(req, res) {
  var n1 = req.body.num1;
  var n2 = req.body.num2;
  var sum = parseInt(n1) + parseInt(n2);
  res.send(n1 + " plus " + n2 + " = " + sum);
}

var attachService = function (app) {
  app.get("/greeting", greeting);
  app.post("/add", additon);
};
exports.attachService = attachService;
