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

module.exports = {
  registerDoctor,
};
