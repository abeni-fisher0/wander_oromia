const express = require("express");
const router = express.Router();
const auth = require("../middlewares/auth");
const { registerUser } = require("../services/authService");

// Called after Firebase Auth signup — sets role in Fs

router.post("/register", auth, registerUser);

module.exports = router;
