const express = require("express");
const router = express.Router();
const auth = require("../middlewares/auth");
const {
  uploadProfile,
  joinTrail,
  getProfile,
  updateProfile,
  getJoinedTrails
} = require("../services/guideService");

router.post("/upload-profile", auth, uploadProfile);
router.get("/joined-trails", auth, getJoinedTrails);
router.post("/join-trail", auth, joinTrail);
router.get("/profile", auth, getProfile);
router.post("/update-profile", auth, updateProfile);

module.exports = router;
