const UserModel = require('../models/user.model');
const DrModel = require('../models/doctor.model');
const SessionModel = require('../models/session.model');
const jwt = require('jsonwebtoken');

// Generate JWT token
const generateToken = (userId, role) => {
  return jwt.sign(
    { userId, role },
    process.env.JWT_SECRET,
    { expiresIn: '7d' }
  );
};

// Clear previous sessions for a user
const clearPreviousSessions = async (userId) => {
  await SessionModel.deleteMany({ userId });
};

exports.login = async (req, res) => {
  const { email, password } = req.body;
  const deviceInfo = req.headers['user-agent'] || 'unknown';

  try {
    
    // Check if the user is a patient
    const user = await UserModel.findOne({ email });
    if (user) {
      const isPasswordMatch = await user.comparePassword(password);
      
      if (isPasswordMatch) {
        // Generate token
        const token = generateToken(user._id, "patient");
        
        // Clear previous sessions if you want to allow only one device at a time
        await clearPreviousSessions(user._id);
        
        // Create new session
        await SessionModel.create({
          userId: user._id,
          role: "patient",
          token,
          device: deviceInfo
        });

        return res.status(200).json({
          success: true,
          role: "patient",
          userId: user._id,
          userName: user.userName,
          email: user.email,
          token, // Send token to client
          message: "Login successful as a patient",
        });
      }
    } else {
      console.log(`No user found with email: ${email}`);
    }

    // Check if the user is a doctor
    const doctor = await DrModel.findOne({ email });
    if (doctor) {
      console.log(`Found doctor with email: ${email}`);
      const isPasswordMatch = await doctor.comparePassword(password);
      console.log(`Password match for doctor: ${isPasswordMatch}`);
      
      if (isPasswordMatch) {
        // Generate token
        const token = generateToken(doctor._id, "doctor");
        
        // Clear previous sessions
        await clearPreviousSessions(doctor._id);
        
        // Create new session
        await SessionModel.create({
          userId: doctor._id,
          role: "doctor",
          token,
          device: deviceInfo
        });
        
        return res.status(200).json({
          success: true,
          role: "doctor",
          userId: doctor._id,
          userName: doctor.doctorName,
          email: doctor.email,
          specialization: doctor.specialization,
          token, // Send token to client
          message: "Login successful as a doctor",
        });
      }
    } else {
      console.log(`No doctor found with email: ${email}`);
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

// Logout function to invalidate the current session
exports.logout = async (req, res) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
      return res.status(400).json({
        success: false,
        message: "No token provided"
      });
    }
    
    // Remove the session
    await SessionModel.findOneAndDelete({ token });
    
    res.status(200).json({
      success: true,
      message: "Logged out successfully"
    });
  } catch (err) {
    console.error("Error during logout:", err);
    res.status(500).json({
      success: false,
      message: "An error occurred while logging out"
    });
  }
}; 