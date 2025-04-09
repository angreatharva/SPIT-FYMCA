// routes/showRoutes.js
const express = require('express');
const router = express.Router();
const showController = require('../controllers/showController');

router.get('/', showController.getAllShows);
router.post('/', showController.createShow);
router.put('/book/:id', showController.bookSeats);

module.exports = router;
