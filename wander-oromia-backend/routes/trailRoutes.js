const express = require("express");
const router = express.Router();
const { getAllTrails, createTrail, getTrailsByCategory, searchTrails } = require("../controllers/trailController");
const auth = require("../middleware/auth");

// Public: all users can view trails
router.get("/", getAllTrails);


router.get("/category/:category", getTrailsByCategory); 
router.get("/search", searchTrails);

module.exports = router;
