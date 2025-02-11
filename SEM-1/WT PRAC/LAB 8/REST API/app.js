const express = require("express");
const bodyParser = require("body-parser");
const studentController = require("./controller/student.controller");

const app = express();

app.use(bodyParser.json({ limit: "100mb" }));
app.use(bodyParser.urlencoded({ limit: "100mb", extended: true }));

app.post("/registerStudent", studentController.registerStudent);
app.get("/students", studentController.getAllStudents);
app.get("/studentsById", studentController.getStudentById);
app.put("/updateStudent", studentController.updateStudent);
app.patch("/patchStudent", studentController.patchStudent);
app.delete("/deleteStudent", studentController.deleteStudent);

module.exports = app;
