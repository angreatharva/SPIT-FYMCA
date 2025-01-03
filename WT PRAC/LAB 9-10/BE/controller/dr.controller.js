const { response } = require("../app");
const DrService = require("../services/dr.services");
const DrModel = require("../model/dr.model");

exports.registerDr = async (req, res) => {
  try {
    const successRes = await DrService.registerDr(req.body);
    res.status(201).json({
      registered: true,
      data: successRes,
      response: "Registered User Successfully!",
    });
  } catch (e) {
    console.error("Error registering User:", e);
    res.status(500).json({
      registered: false,
      response: "Error registering User",
    });
  }
};

exports.getAllDoctors = async (req, res) => {
  try {
    const doctors = await DrService.getAllDoctors();
    res.status(200).json({
      success: true,
      data: doctors,
    });
  } catch (error) {
    console.error("Error fetching doctors:", error);
    res.status(500).json({
      success: false,
      message: "Error fetching doctor list",
    });
  }
};

exports.updateDrStatus = async (req, res) => {
  const { id } = req.params;

  try {
    const updatedDoctor = await DrModel.findByIdAndUpdate(
      id,
      { status: true },
      { new: true }
    );

    if (!updatedDoctor) {
      return res.status(404).json({
        success: false,
        message: "Doctor not found",
      });
    }

    res.status(200).json({
      success: true,
      message: "Doctor status updated successfully",
      doctor: updatedDoctor,
    });
  } catch (error) {
    console.error("Error updating doctor status:", error);
    res.status(500).json({
      success: false,
      message: "An error occurred while updating the doctor status",
    });
  }
};
