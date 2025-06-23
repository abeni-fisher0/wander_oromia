const express = require("express");
const router = express.Router();
const {
  getStopsByTrail,
  createStop,
} = require("../controllers/stopController");
const auth = require("../middleware/auth");

// Get all stops under a trail
router.get("/:trailId", getStopsByTrail);

// Add a new stop (auth required)
router.post("/", auth, createStop);

module.exports = router;
