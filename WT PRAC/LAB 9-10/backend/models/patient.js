const mongoose = require("mongoose");

const patientSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  last_name: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true
  },
  phone: {
    type: String,
    required: true
  },
  age: {
    type: Number,
    required: true
  },
  gender: {
    type: String,
    enum: ["male", "female", "other"],
    required: true
  },
  password: {
    type: String,
    required: true
  },
  
  marital_status: {
    type: String,
    enum: ["single", "married", "divorced", "widowed"],
    required: true
  },
  relationship_status: {
    type: String,
    enum: ["single", "in_relationship", "complicated"],
    required: true
  },
  therapy_type: {
    type: [String], // Allow multiple therapy types
    required: true
  }
});

const Patient = mongoose.model("Patient", patientSchema);

module.exports = Patient;
