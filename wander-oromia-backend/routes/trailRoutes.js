const express = require("express");
const router = express.Router();
const {
  getAllTrails,
  createTrail,
  getTrailsByCategory,
  searchTrails,
  getTrailById,
} = require("../controllers/trailController");
const auth = require("../middleware/auth");

// Public: all users can view trails
router.get("/", getAllTrails);

// Private: only logged-in users can create
router.post("/", auth, createTrail);
router.get("/category/:category", getTrailsByCategory);
router.get("/search", searchTrails);
// trailRoutes.js
router.get("/:id", getTrailById);

module.exports = router;
