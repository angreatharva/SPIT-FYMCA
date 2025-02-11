const StudentModel = require("../model/student.model");

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

  static async updateStudent(studentId, updateData) {
    try {
      return await StudentModel.findOneAndUpdate(
        { studentId: studentId },
        updateData,
        { new: true }
      );
    } catch (e) {
      throw e;
    }
  }

  static async patchStudent(studentId, patchData) {
    try {
      return await StudentModel.findOneAndUpdate(
        { studentId: studentId },
        { $set: patchData },
        { new: true }
      );
    } catch (e) {
      throw e;
    }
  }

  static async deleteStudent(studentId) {
    try {
      return await StudentModel.findOneAndDelete({ studentId: studentId });
    } catch (e) {
      throw e;
    }
  }
}

module.exports = StudentService;
