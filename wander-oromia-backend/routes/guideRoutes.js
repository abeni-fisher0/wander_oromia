const express = require('express');
const router = express.Router();
const guideController = require('../controllers/guideController');
const { upload } = require('../config/cloudinary');

// Create guide with photo upload
router.post('/', upload.single('photo'), guideController.createGuide);
router.get('/saved-trails/:userId', guideController.getSavedTrailsByUser);
// Get all guides
router.get('/', guideController.getAllGuides);

// Get guides by trail
router.get('/trail/:trailId', guideController.getGuidesByTrail);

module.exports = router;
