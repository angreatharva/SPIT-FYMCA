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

exports.getRegisteredUsers = async (req, res) => {
  try {
    const users = await UserService.getAllUsers();
    res.status(200).json({
      success: true,
      data: users,
      response: "Fetched registered users successfully!",
    });
  } catch (e) {
    console.error("Error fetching registered users:", e);
    res.status(500).json({
      success: false,
      response: "Error fetching registered users",
    });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const userId = req.params.id;
    
    if (!userId) {
      return res.status(400).json({
        success: false,
        response: "User ID is required"
      });
    }
    
    const user = await UserService.getUserById(userId);
    
    res.status(200).json({
      success: true,
      data: user,
      response: "User details fetched successfully"
    });
  } catch (e) {
    console.error("Error fetching user details:", e);
    
    // Check if it's a "User not found" error
    if (e.message === 'User not found') {
      return res.status(404).json({
        success: false,
        response: "User not found"
      });
    }
    
    // For other errors
    res.status(500).json({
      success: false,
      response: "Error fetching user details"
    });
  }
};
