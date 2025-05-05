const mongoose = require("../config/db");
const bcrypt = require("bcrypt");

const { Schema } = mongoose;

/**
 * @swagger
 * components:
 *   schemas:
 *     Doctor:
 *       type: object
 *       required:
 *         - doctorName
 *         - phone
 *         - age
 *         - gender
 *         - email
 *         - qualification
 *         - specialization
 *         - licenseNumber
 *         - image
 *         - password
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         doctorName:
 *           type: string
 *           description: Doctor's full name
 *         phone:
 *           type: string
 *           description: Doctor's phone number
 *         age:
 *           type: integer
 *           description: Doctor's age
 *         gender:
 *           type: string
 *           description: Doctor's gender
 *           enum: [male, female, other]
 *         email:
 *           type: string
 *           format: email
 *           description: Doctor's email address (unique)
 *         qualification:
 *           type: string
 *           description: Doctor's medical qualification
 *         specialization:
 *           type: string
 *           description: Doctor's medical specialization
 *         licenseNumber:
 *           type: string
 *           description: Doctor's medical license number (unique)
 *         image:
 *           type: string
 *           format: binary
 *           description: Doctor's profile image
 *         isActive:
 *           type: boolean
 *           description: Doctor's availability status
 *           default: false
 *         password:
 *           type: string
 *           format: password
 *           description: Doctor's hashed password
 *       example:
 *         _id: 60d0fe4f5311236168a109cb
 *         doctorName: Dr. Jane Smith
 *         phone: "9876543210"
 *         age: 40
 *         gender: female
 *         email: dr.jane.smith@example.com
 *         qualification: MBBS, MD
 *         specialization: Cardiology
 *         licenseNumber: MED12345
 *         isActive: true
 */
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
