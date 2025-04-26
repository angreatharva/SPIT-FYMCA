const UserModel = require('../models/user.model');
const DrModel = require('../models/doctor.model');

exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check if the user is a patient
    const user = await UserModel.findOne({ email });
    if (user && (await user.comparePassword(password))) {
      return res.status(200).json({
        success: true,
        role: "patient",
        userId: user._id,
        userName: user.userName,
        email: user.email,
        message: "Login successful as a patient",
      });
    }

    // Check if the user is a doctor
    const doctor = await DrModel.findOne({ email });
    if (doctor && (await doctor.comparePassword(password))) {
      return res.status(200).json({
        success: true,
        role: "doctor",
        userId: doctor._id,
        userName: doctor.doctorName,
        email: doctor.email,
        specialization: doctor.specialization,
        message: "Login successful as a doctor",
      });
    }

    // If no match is found
    return res.status(401).json({
      success: false,
      message: "Invalid email or password",
    });
  } catch (err) {
    console.error("Error during login:", err);
    res.status(500).json({
      success: false,
      message: "An error occurred while logging in",
    });
  }
}; 