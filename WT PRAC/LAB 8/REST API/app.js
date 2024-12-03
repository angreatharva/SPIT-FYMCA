const express = require("express");
const bodyParser = require("body-parser");
const studentController = require("./controller/student.controller");

const app = express();

app.use(bodyParser.json({ limit: "100mb" }));
app.use(bodyParser.urlencoded({ limit: "100mb", extended: true }));

app.post("/registerStudent", studentController.registerStudent);
app.get("/students", studentController.getAllStudents);
app.get("/studentsById", studentController.getStudentById);

module.exports = app;
