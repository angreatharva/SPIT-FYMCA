// routes/movieRoutes.js
const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const movieController = require('../controllers/movieController');

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ 
  storage: storage,
  fileFilter: function (req, file, cb) {
    if (file.mimetype.startsWith('image/')) {
      cb(null, true);
    } else {
      cb(new Error('Not an image! Please upload an image.'), false);
    }
  }
});

router.get('/', movieController.getAllMovies);
router.post('/', upload.single('poster'), movieController.createMovie);

module.exports = router;
