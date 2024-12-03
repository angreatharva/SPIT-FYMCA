const { response } = require("../app");
const StudentService = require("../services/student.services");

exports.registerStudent = async (req, res) => {
  try {
    const successRes = await StudentService.registerStudent(req.body);
    res.status(201).json({
      registered: true,
      response: "Registered Student Successfully!",
    });
  } catch (e) {
    console.error("Error registering student:", e);
    res.status(500).json({
      registered: false,
      response: "Error registering student",
    });
  }
};

exports.getAllStudents = async (req, res, next) => {
  try {
    const students = await StudentService.getAllStudents();
    res.json({ data: students });
  } catch (e) {
    res.status(500).json({ status: false, message: e.message });
  }
};

exports.getStudentById = async (req, res, next) => {
  const studentId = req.query.studentId;

  if (!studentId) {
    return res
      .status(400)
      .json({ status: false, message: "Student ID is required" });
  }

  try {
    const student = await StudentService.getStudentById(studentId);
    if (student) {
      res.json({ status: true, student });
    } else {
      res.status(404).json({ status: false, message: "Student not found" });
    }
  } catch (e) {
    res.status(500).json({ status: false, message: e.message });
  }
};
