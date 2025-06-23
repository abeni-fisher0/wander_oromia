const express = require("express");
const router = express.Router();
const {
  saveTrail,
  getSavedTrails,
} = require("../controllers/savedTrailController");
const auth = require("../middleware/auth");

// Save a trail for current user
router.post("/", auth, saveTrail);

// Get saved trails for current user
router.get("/", auth, getSavedTrails);

module.exports = router;
