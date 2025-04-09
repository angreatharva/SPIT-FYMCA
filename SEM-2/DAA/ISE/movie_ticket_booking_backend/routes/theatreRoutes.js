// routes/theatreRoutes.js
const express = require('express');
const router = express.Router();
const theatreController = require('../controllers/theatreController');

router.get('/', theatreController.getAllTheatres);
router.post('/', theatreController.createTheatre);

module.exports = router;
