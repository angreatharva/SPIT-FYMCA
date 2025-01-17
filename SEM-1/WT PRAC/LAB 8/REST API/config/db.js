const mongoose = require("mongoose");

mongoose
  .connect("mongodb://localhost:27017/Student", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("MongoDB Connected");
  })
  .catch((error) => {
    console.error("Connection Error:", error);
  });

module.exports = mongoose;
