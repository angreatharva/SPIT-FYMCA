const mongoose = require("../config/db");
const { Schema } = mongoose;

const studentSchema = new Schema({
  studentId: {
    type: Number,
    required: true,
  },
  studentName: {
    type: String,
    required: true,
  },
});

const StudentModel = mongoose.model(
  "studentData",
  studentSchema,
  "studentData"
);
module.exports = StudentModel;
