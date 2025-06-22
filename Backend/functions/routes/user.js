const express = require("express");
const router = express.Router();
const auth = require("../middlewares/auth");
const { getProfile, updateProfile } = require("../services/userService");

router.get("/me", auth, getProfile);
router.post("/update", auth, updateProfile);

module.exports = router;
