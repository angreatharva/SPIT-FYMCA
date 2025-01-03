const UserService = require("../services/user.services");
const DrService = require("../services/dr.services");

exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    const patient = await UserService.findByCredentials(email, password);
    if (patient) {
      return res.status(200).json({
        success: true,
        role: "patient",
        message: "Login successful as a patient!",
        data: patient,
      });
    }

    const doctor = await DrService.findByCredentials(email, password);
    if (doctor) {
      return res.status(200).json({
        success: true,
        role: "doctor",
        message: "Login successful as a doctor!",
        data: doctor,
      });
    }

    res.status(401).json({
      success: false,
      message: "Invalid email or password.",
    });
  } catch (e) {
    console.error("Error during login:", e);
    res.status(500).json({
      success: false,
      message: "An error occurred during login.",
    });
  }
};
