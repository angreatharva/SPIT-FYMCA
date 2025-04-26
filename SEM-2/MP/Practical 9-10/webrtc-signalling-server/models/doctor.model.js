const mongoose = require("../config/db");
const bcrypt = require("bcrypt");

const { Schema } = mongoose;

const doctorSchema = new Schema({
  doctorName: {
    type: String,
    required: true,
  },
  phone: {
    type: String,
    required: true,
  },
  age: {
    type: Number,
    required: true,
  },
  gender: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  qualification: {
    type: String,
    required: true,
  },
  specialization: {
    type: String,
    required: true,
  },
  licenseNumber: {
    type: String,
    required: true,
    unique: true,
  },
  image: {
    required: true,
    type: Buffer,
  },
  isActive: {
    required: true,
    default: false,
    type: Boolean,
  },
  password: {
    type: String,
    required: true,
  },
});

// Pre-save hook to hash the password
doctorSchema.pre("save", async function (next) {
  if (this.isModified("password")) {
    try {
      const salt = await bcrypt.genSalt(10);
      this.password = await bcrypt.hash(this.password, salt);
    } catch (err) {
      return next(err);
    }
  }
  next();
});

// Method to compare passwords
doctorSchema.methods.comparePassword = async function (candidatePassword) {
  try {
    return await bcrypt.compare(candidatePassword, this.password);
  } catch (err) {
    throw err;
  }
};

// Method to toggle active status
doctorSchema.methods.toggleActive = async function() {
  try {
    this.isActive = !this.isActive;
    return await this.save();
  } catch (err) {
    throw err;
  }
};

const DoctorModel = mongoose.model("doctorData", doctorSchema, "doctorData");
module.exports = DoctorModel;
