const express = require("express");
const router = express.Router();
const { getProfile, updateProfile } = require("../controllers/userController");
const auth = require("../middleware/auth");

// Profile routes (for both roles)
router.get("/me", auth, getProfile);
router.put("/me", auth, updateProfile);

module.exports = router;
