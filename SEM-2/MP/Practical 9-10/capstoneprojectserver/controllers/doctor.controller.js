const Doctor = require('../models/doctor.model');
const doctorService = require("../services/doctor.services");
const socketService = require("../services/socket.service");

const doctorController = {
  // Get all available doctors
  getAvailableDoctors: async (req, res) => {
    try {
      const doctors = await Doctor.find({ isActive: true });
      res.json({
        success: true,
        doctors: doctors
      });
    } catch (error) {
      console.error('Error fetching available doctors:', error);
      res.status(500).json({
        success: false,
        message: 'Error fetching available doctors',
        error: error.message
      });
    }
  },

  // Get doctor's current status
  getDoctorStatus: async (req, res) => {
    try {
      console.log('Getting status for doctor ID:', req.params.id);
      const doctor = await Doctor.findById(req.params.id);
      if (!doctor) {
        console.log('Doctor not found with ID:', req.params.id);
        return res.status(404).json({
          success: false,
          message: 'Doctor not found'
        });
      }

      console.log('Doctor status:', doctor.isActive);
      res.json({
        success: true,
        isActive: doctor.isActive
      });
    } catch (error) {
      console.error('Error fetching doctor status:', error);
      res.status(500).json({
        success: false,
        message: 'Error fetching doctor status',
        error: error.message
      });
    }
  },

  // Get doctor details by ID
  getDoctorById: async (req, res) => {
    try {
      const doctorId = req.params.id;
      
      if (!doctorId) {
        return res.status(400).json({
          success: false,
          message: "Doctor ID is required"
        });
      }
      
      const doctor = await doctorService.getDoctorById(doctorId);
      
      res.status(200).json({
        success: true,
        data: doctor,
        message: "Doctor details fetched successfully"
      });
    } catch (error) {
      console.error("Error fetching doctor details:", error);
      
      // Check if it's a "Doctor not found" error
      if (error.message === 'Doctor not found') {
        return res.status(404).json({
          success: false,
          message: "Doctor not found"
        });
      }
      
      // For other errors
      res.status(500).json({
        success: false,
        message: "Error fetching doctor details",
        error: error.message
      });
    }
  },

  // Toggle doctor's active status
  toggleDoctorStatus: async (req, res) => {
    try {
      const doctorId = req.params.id;
      console.log('Toggling status for doctor ID:', doctorId);

      // First get the current status
      const doctor = await Doctor.findById(doctorId);
      if (!doctor) {
        console.log('Doctor not found with ID:', doctorId);
        return res.status(404).json({
          success: false,
          message: 'Doctor not found'
        });
      }

      // Update the status to its opposite
      const updatedDoctor = await Doctor.findByIdAndUpdate(
        doctorId,
        { $set: { isActive: !doctor.isActive } },
        { new: true }
      );

      console.log('Doctor status updated to:', updatedDoctor.isActive);
      
      // Emit socket event to notify clients of status change
      socketService.emitDoctorStatusChange(doctorId, updatedDoctor.isActive);
      
      res.json({
        success: true,
        isActive: updatedDoctor.isActive,
        message: `Doctor is now ${updatedDoctor.isActive ? 'active' : 'inactive'}`
      });
    } catch (error) {
      console.error('Error toggling doctor status:', error);
      res.status(500).json({
        success: false,
        message: 'Error toggling doctor status',
        error: error.message
      });
    }
  },

  // Register a new doctor
  registerDoctor: async (req, res) => {
    const { image } = req.body;

    if (!image) {
      return res.status(400).json({
        success: false,
        message: "No image uploaded.",
      });
    }

    try {
      // Decode the base64 string to buffer
      const imageBuffer = Buffer.from(image, "base64");

      // Prepare doctor data from request body and image buffer
      const doctorData = {
        name: req.body.doctorName,
        email: req.body.email,
        password: req.body.password,
        specialization: req.body.specialization,
        imageUrl: req.body.imageUrl || 'https://picsum.photos/200', // Default avatar if no image
        rating: 0, // Default rating for new doctors
        isActive: false // Default to inactive
      };

      const doctor = new Doctor(doctorData);
      const savedDoctor = await doctor.save();

      res.status(201).json({
        success: true,
        data: savedDoctor,
        message: "Doctor registered successfully!",
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Error registering doctor: " + error.message,
      });
    }
  }
};

module.exports = doctorController;
