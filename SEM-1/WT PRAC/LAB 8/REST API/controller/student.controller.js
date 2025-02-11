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

exports.getAllStudents = async (req, res) => {
  try {
    const students = await StudentService.getAllStudents();
    res.json({ data: students });
  } catch (e) {
    res.status(500).json({ status: false, message: e.message });
  }
};

exports.getStudentById = async (req, res) => {
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

exports.updateStudent = async (req, res) => {
  const studentId = req.body.studentId;
  const updateData = req.body;

  if (!studentId) {
    return res
      .status(400)
      .json({ status: false, message: "Student ID is required" });
  }

  try {
    const updatedStudent = await StudentService.updateStudent(
      studentId,
      updateData
    );
    res.json({
      status: true,
      message: "Student updated successfully",
      updatedStudent,
    });
  } catch (e) {
    res.status(500).json({ status: false, message: e.message });
  }
};

exports.patchStudent = async (req, res) => {
  const studentId = req.body.studentId;
  const patchData = req.body;

  if (!studentId) {
    return res
      .status(400)
      .json({ status: false, message: "Student ID is required" });
  }

  try {
    const patchedStudent = await StudentService.patchStudent(
      studentId,
      patchData
    );
    res.json({
      status: true,
      message: "Student patched successfully",
      patchedStudent,
    });
  } catch (e) {
    res.status(500).json({ status: false, message: e.message });
  }
};

exports.deleteStudent = async (req, res) => {
  const studentId = req.query.studentId;

  if (!studentId) {
    return res
      .status(400)
      .json({ status: false, message: "Student ID is required" });
  }

  try {
    await StudentService.deleteStudent(studentId);
    res.json({ status: true, message: "Student deleted successfully" });
  } catch (e) {
    res.status(500).json({ status: false, message: e.message });
  }
};
