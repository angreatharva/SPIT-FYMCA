const Doctor = require("../models/doctor.model");

// Service for registering a doctor
const registerDoctor = async (doctorData) => {
  const newDoctor = new Doctor({
    doctorName: doctorData.doctorName,
    phone: doctorData.phone,
    age: doctorData.age,
    gender: doctorData.gender,
    email: doctorData.email,
    qualification: doctorData.qualification,
    specialization: doctorData.specialization,
    licenseNumber: doctorData.licenseNumber,
    password: doctorData.password,
    image: doctorData.image, // Store the image buffer
  });

  try {
    const savedDoctor = await newDoctor.save();
    return savedDoctor;
  } catch (error) {
    throw new Error("Error saving doctor: " + error.message);
  }
};

// Service for getting doctor details by ID
const getDoctorById = async (doctorId) => {
  try {
    // Find doctor by ID
    const doctor = await Doctor.findById(doctorId);
    
    if (!doctor) {
      throw new Error('Doctor not found');
    }
    
    // Convert to plain object and remove sensitive data
    const doctorObject = doctor.toObject();
    delete doctorObject.password;
    
    // Convert image buffer to base64 if it exists
    if (doctorObject.image) {
      doctorObject.imageBase64 = doctorObject.image.toString('base64');
      delete doctorObject.image; // Remove the buffer to avoid sending large binary data
    }
    
    return doctorObject;
  } catch (error) {
    console.error('Error fetching doctor by ID:', error);
    throw error;
  }
};

module.exports = {
  registerDoctor,
  getDoctorById
};
