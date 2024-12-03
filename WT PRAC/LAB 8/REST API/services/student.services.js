const StudentModel = require("../model/student.Model");

class StudentService {
  static async registerStudent(data) {
    try {
      const createStudent = new StudentModel(data);
      return await createStudent.save();
    } catch (e) {
      throw e;
    }
  }

  static async getAllStudents() {
    try {
      return await StudentModel.find();
    } catch (e) {
      throw e;
    }
  }

  static async getStudentById(studentId) {
    try {
      return await StudentModel.findOne({ studentId: studentId });
    } catch (e) {
      throw e;
    }
  }
}

module.exports = StudentService;
