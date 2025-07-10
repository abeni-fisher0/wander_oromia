const express = require('express');
const router = express.Router();
const {
  createItinerary,
  getMyItineraries,
} = require('../controllers/itineraryController');
const auth = require('../middleware/auth');

router.post('/', auth, createItinerary);
router.get('/', auth, getMyItineraries);

module.exports = router;
