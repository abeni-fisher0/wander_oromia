const express = require("express");
const router = express.Router();
const auth = require("../middlewares/auth");
const {
  saveTrail,
  updateItinerary,
  selectGuide,
  rateGuide,
  rateTrail,
  getItinerary,
  getSavedTrails
} = require("../services/touristService");

router.post("/save-trail", auth, saveTrail);
router.get("/saved-trails", auth, getSavedTrails);
router.get("/itinerary", auth, getItinerary);
router.post("/update-itinerary", auth, updateItinerary);
router.post("/select-guide", auth, selectGuide);
router.post("/rate-trail", auth, rateTrail);
router.post("/rate-guide", auth, rateGuide);

module.exports = router;
