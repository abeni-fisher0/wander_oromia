const { uploadGuideProfile, registerTrail, getGuideProfile } = require("../models/guideModel");

exports.uploadProfile = async (req, res) => {
  const uid = req.user.uid;
  const data = req.body;

  try {
    await uploadGuideProfile(uid, data);
    res.status(200).json({ message: "Guide profile uploaded" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to upload guide profile" });
  }
};

exports.joinTrail = async (req, res) => {
  const uid = req.user.uid;
  const { trailId } = req.body;

  if (!trailId) return res.status(400).json({ error: "trailId is required" });

  try {
    await registerTrail(uid, trailId);
    res.status(200).json({ message: "Trail joined successfully" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Could not join trail" });
  }
};

exports.getProfile = async (req, res) => {
  const uid = req.user.uid;

  try {
    const guide = await getGuideProfile(uid);
    if (!guide) return res.status(404).json({ error: "Guide not found" });
    res.status(200).json(guide);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch guide profile" });
  }
};

exports.updateProfile = async (req, res) => {
  const uid = req.user.uid;
  const data = req.body;

  try {
    await uploadGuideProfile(uid, data);
    res.status(200).json({ message: "Guide profile updated" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Could not update guide profile" });
  }
};
exports.getJoinedTrails = async (req, res) => {
  const uid = req.user.uid;
  try {
    const guide = await getGuideProfile(uid);
    res.status(200).json(guide?.registeredTrails || []);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch joined trails" });
  }
};
