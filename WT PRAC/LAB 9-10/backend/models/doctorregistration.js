const mongoose = require('mongoose');

const doctorregistrationSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true,
    unique: true, // Ensure uniqueness
    lowercase: true, // Convert email to lowercase
  },
  phone: {
    type: Number,
    unique:true,

    // You can add more validation rules for phone number if needed
  },
  degreeName: String,
  password: {
    type: String,
    required: true,
 
  },
  confirmPassword: {
    type: String,
    required: true,
    validate: {
      validator: function(value) {
        // Check if confirmPassword matches password
        return value === this.password;
      },
      message: props => `Passwords do not match!`
    }
  },
  profilePic: String,
  age: Number,
  gender: String,
  experienceInYears: Number,
  degree: String,
  status: {
    type: String,
    default: 'pending'
  }
});
 
const Doctor = mongoose.model("doctorregistration", doctorregistrationSchema);

module.exports = Doctor;