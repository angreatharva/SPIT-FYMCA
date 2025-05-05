const mongoose = require("../config/db");
const bcrypt = require("bcrypt");

const { Schema } = mongoose;

/**
 * @swagger
 * components:
 *   schemas:
 *     User:
 *       type: object
 *       required:
 *         - userName
 *         - phone
 *         - age
 *         - gender
 *         - email
 *         - password
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         userName:
 *           type: string
 *           description: User's full name
 *         phone:
 *           type: string
 *           description: User's phone number
 *         age:
 *           type: integer
 *           description: User's age
 *         gender:
 *           type: string
 *           description: User's gender
 *           enum: [male, female, other]
 *         email:
 *           type: string
 *           format: email
 *           description: User's email address (unique)
 *         password:
 *           type: string
 *           format: password
 *           description: User's hashed password
 *       example:
 *         _id: 60d0fe4f5311236168a109ca
 *         userName: John Doe
 *         phone: "1234567890"
 *         age: 30
 *         gender: male
 *         email: john.doe@example.com
 */
const userSchema = new Schema({
  userName: {
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
  password: {
    type: String,
    required: true,
  },
});

// Pre-save hook to hash the password
userSchema.pre("save", async function (next) {
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
userSchema.methods.comparePassword = async function (candidatePassword) {
  try {
    return await bcrypt.compare(candidatePassword, this.password);
  } catch (err) {
    throw err;
  }
};

const UserModel = mongoose.model("userData", userSchema, "userData");
module.exports = UserModel;
