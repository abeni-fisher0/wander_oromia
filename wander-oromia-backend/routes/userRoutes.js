const express = require("express");
const router = express.Router();
const multer = require("multer");
const path = require("path");
const {
  getProfile,
  updateProfile,
  uploadAvatar,
} = require("../controllers/userController");
const auth = require("../middleware/auth");

// 📷 Set up multer storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/"); // Make sure this folder exists
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const filename = `${req.user.uid}-avatar${ext}`;
    cb(null, filename);
  },
});
const upload = multer({ storage });

// ✅ Profile routes
router.get("/me", auth, getProfile);
router.put("/me", auth, updateProfile);

// ✅ NEW: Avatar Upload
router.post("/me/avatar", auth, upload.single("avatar"), uploadAvatar);

module.exports = router;
