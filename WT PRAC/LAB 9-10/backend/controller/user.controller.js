const { response } = require("../app");
const UserService = require("../services/user.services");

exports.registerUser = async (req, res) => {
  try {
    const successRes = await UserService.registerUser(req.body);
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
