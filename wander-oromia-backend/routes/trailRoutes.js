const express = require("express");
const router = express.Router();
const { getAllTrails, createTrail } = require("../controllers/trailController");
const auth = require("../middleware/auth");

// Public: all users can view trails
router.get("/", getAllTrails);

// Private: only logged-in users can create
router.post("/", auth, createTrail);

module.exports = router;
