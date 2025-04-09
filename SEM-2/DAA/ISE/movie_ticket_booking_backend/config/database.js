const mongoose = require("mongoose");

mongoose
  .connect("mongodb://127.0.0.1:27017/movieticket", {
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
