const express = require("express");
const router = express.Router();
const {
  createItinerary,
  getMyItineraries,
} = require("../controllers/itineraryController");
const auth = require("../middleware/auth");
const restrictTo = require("../middleware/role");

// Tourists only
router.post("/", auth, restrictTo("tourist"), createItinerary);
router.get("/", auth, restrictTo("tourist"), getMyItineraries);

module.exports = router;
