const mongoose = require("mongoose");

mongoose
  .connect(
    "mongodb+srv://angreatharva08:KwIo8LImIRwqo606@majorproject.g28mo.mongodb.net/",
    {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    }
  )
  .then(() => {
    console.log("MongoDB Connected");
  })
  .catch((error) => {
    console.error("Connection Error:", error);
  });

module.exports = mongoose;
