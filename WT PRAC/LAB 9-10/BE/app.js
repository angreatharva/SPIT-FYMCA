const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const userController = require("./controller/user.controller");
const drController = require("./controller/dr.controller");
const blogController = require("./controller/blogs.controller");
const UserModel = require("./model/user.model");
const DrModel = require("./model/dr.model");

const app = express();
app.use(
  cors({
    origin: "http://localhost:5173",
  })
);
app.use(express.json());

app.use(bodyParser.json({ limit: "100mb" }));
app.use(bodyParser.urlencoded({ limit: "100mb", extended: true }));

app.post("/registerUser", userController.registerUser);
app.post("/registerDr", drController.registerDr);
app.get("/doctors", drController.getAllDoctors);
app.put("/updateDrStatus/:id", drController.updateDrStatus);
app.post("/createBlog", blogController.createBlog);
app.get("/allBlog", blogController.getAllBlogs);
app.put("/updateBlog/:id", blogController.updateBlog);
app.get("/getBlog/:id", blogController.getBlogById);
app.get("/blogsByAuthor/:by", blogController.getBlogsByAuthor);
app.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check if the user is a patient
    const user = await UserModel.findOne({ email });
    if (user && (await user.comparePassword(password))) {
      return res.status(200).json({
        success: true,
        role: "patient",
        userId: user._id,
        name: user.userName,
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
        name: doctor.userName,
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
});

module.exports = app;
