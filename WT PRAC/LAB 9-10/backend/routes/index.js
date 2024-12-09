var express = require('express');
var router = express.Router();
var mongoose = require("mongoose");
var Doctor = require("../models/doctorregistration"); //this is for doctor registration
const Patient = require("../models/patient");
const Appointment = require('../models/appointment'); // Adjust the path as needed


// Admin Panel
//patient data
router.get('/adamarjumand', async (req, res) => {
  try {
    // Retrieve all patient data from the database
    const patients = await Patient.find();

    // Render the EJS template with patient data
    res.render('adminpage/adamarjumand', { patients });
  } catch (error) {
    console.error('Error fetching patients:', error);
    res.status(500).send('Internal Server Error');
  }
});

//doctor data
router.get('/doctor', async (req, res) => {
  try {
    const doctors = await Doctor.find();
    res.render('adminpage/doctor', { doctors });
  } catch (error) {
    console.error('Error fetching doctors:', error);
    res.status(500).send('Internal Server Error');
  }
});


// Route to render the page with users and delete functionality
router.get('/deletedoctor', async (req, res) => {
  try {
    const doctors = await Doctor.find();
    res.render('adminpage/doctor', { doctors });
  } catch (err) {
      console.error(err);
      res.status(500).send('Error fetching users');
  }
});

// Route to handle user deletion
router.post('/deletedoctor', async (req, res) => {
  const doctors = req.body.userId;
  try {
      await User.findByIdAndDelete(userId);
      res.redirect('adminpage/doctor');
  } catch (err) {
      console.error(err);
      res.status(500).send('Error deleting user');
  }
});

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
});

router.get('/lndex', function(req, res, next) {
  res.render('lndex');
});

router.get('/logout', function(req, res, next) {
  res.render('index');
});

router.get('/indexblog', function(req, res, next) {
  res.render('indexblog');
});

router.get('/dashboard', function(req, res, next) {
  res.render('dashboard');
});

router.get('/services', function(req, res, next) {
  res.render('Servies');
});

router.get('/contact', function(req, res, next) {
  res.render('contact');
});

router.get('/about', function(req, res, next) {
  res.render('about');
});

router.get('/room1', function(req, res, next) {
  res.render('room1');
});


router.get('/single-post', function(req, res, next) {
  res.render('single-post');
});
router.get('/singl-epost1', function(req, res, next) {
  res.render('single-post1');
});

router.get('/single-post2', function(req, res, next) {
  res.render('single-post2');
});

//patient registration
router.post("/patientregister", async (req, res) => {
  try {
    // Extract user data from request body
    var name = req.body.name;
     var last_name = req.body.last_name;
    var age = req.body.age;
    var email = req.body.email;
    var phno = req.body.Phone;
    var gender = req.body.gender;
    var password = req.body.password;
    var conpassword = req.body.confirm_password;

    // Check if password and confirm_password match
    if (password !== conpassword) {
      return res.status(400).send("Passwords do not match");
    }

    // Create a new user instance with extracted data
    var newPatient = new Patient({
      name: name,
      last_name: last_name,
      age: age,
      email: email,
      phone: phno,
      gender: gender,
      password: password,
      confirm_password: conpassword,
      marital_status: req.body.marital_status,
      relationship_status: req.body.relationship_status,
      therapy_type: req.body.therapy_type,
    });

    // Save the user to the database
    await newPatient.save();

    // Send success response
    res.render("lndex");
  } catch (error) {
    // Check if the error is a duplicate key error (email already exists)
    if (error.code === 11000 && error.keyPattern && error.keyPattern.email) {
      return res.status(400).send("Email already exists");
    }

    // Log and send error response for other errors
    console.error("Error creating user:", error);
    res.status(500).send("Error creating user");
  }
});

router.get("/patientregister", function (req, res, next) {
  res.render("patientregister");
});

//Patient Login route
router.post("/patientlogin", async (req, res) => {
  try {
    // Extract email and password from request body
    const { email, password } = req.body;

    // Find user by email
    const user = await Patient.findOne({ email });

    // Check if user exists
    if (!user) {
      return res.status(404).send("User not found");
    }

    // Check if password matches
    if (user.password !== password) {
      return res.status(401).send("Invalid password");
    }

    // Send success response
    res.render("lndex");
  } catch (error) {
    // Log and send error response
    console.error("Error logging in:", error);
    res.status(500).send("Error logging in");
  }
});
router.get("/patientlogin", function (req, res, next) {
  res.render("patientlogin");
});




//doctor registration
router.post("/doctorregister", function (req, res, next) {
  const doctor ={
    name,
    lname,
    email,
    phone,
    degreeName,
    password,
    confirmPassword,
    profilePic,
    age,
    gender,
    experienceInYears,
    degree,
  } = req.body;

  Doctor.create({
      name,
      lname,
      email,
      phone,
      degreeName,
      password,
      confirmPassword,
      profilePic,
      age,
      gender,
      experienceInYears,
      degree,
    })
    .then((doctor) => {
      res.send("Please wait for confirmation");
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send("Error registering doctor");
    });
});

router.get("/doctorregister", function (req, res, next) {
  res.render("doctorregistration");
});
router.post("/doctorsign", async (req, res) => {
  try {
    // Extract email and password from request body
    const { email, password } = req.body;

    // Find user by email
    const doctor = await Doctor.findOne({ email });

    // Check if user exists
    if (!doctor) {
      return res.status(404).send("User not found");
    }

    // Check if password matches
    if (doctor.password !== password) {
      return res.status(401).send("Invalid password");
    }

    // Send success response
    res.render("dashboard");
  } catch (error) {
    // Log and send error response
    console.error("Error logging in:", error);
    res.status(500).send("Error logging in");
  }
});

router.get("/doctorsign", function (req, res, next) {
  res.render("doctorsign");
});




router.get("/appointment", function (req, res, next) {
  res.render("appointment");
});
// Handle appointment form submission
router.post('/appointment', async (req, res) => {
  try {
    const { name, email, phone, date, time, age, gender, therapy, doctor, message } = req.body;
    const appointment = new Appointment({
      name,
      email,
      phone,
      date,
      time,
      age,
      gender,
      therapy,
      doctor,
      message
    });
    await appointment.save();
    res.send('Your appointment request has been received. We will contact you shortly.');
  } catch (error) {
    console.error('Error processing appointment:', error);
    res.status(500).send('An error occurred while processing your appointment request.');
  }
});

module.exports = router;
