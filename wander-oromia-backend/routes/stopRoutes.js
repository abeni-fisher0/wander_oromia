const express = require("express");
const router = express.Router();
const {
  getStopsByTrailTitle,
  getStopByName,
  getAllStops,
  getStopsByTrail,
  createStop,
  getStopsByTrailId,
} = require("../controllers/stopController");
const auth = require("../middleware/auth");



router.get('/', getAllStops); // Get all stops
router.get('/name/:name', getStopByName);
router.get("/by-trail/:title", getStopsByTrailTitle); 
// Get all stops under a trail
router.get("/:trailId", getStopsByTrail);

router.get("/:trailId", getStopsByTrailId);


// Add a new stop (auth required)
router.post("/", auth, createStop);

module.exports = router;
