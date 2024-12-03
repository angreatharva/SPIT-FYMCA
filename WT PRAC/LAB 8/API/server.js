const express = require("express");
const bodyParser = require("body-parser");
const service = require("./service.js");
const path = require("path");

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.get("/", (req, res) => {
  res.sendFile("D:/SPIT-FYMCA/WT PRAC/LAB 8/API/home.html");
});

service.attachService(app);

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
