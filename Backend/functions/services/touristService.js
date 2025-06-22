const { addSavedTrail, updateItinerary, assignGuide, getUser } = require("../models/userModel");
const { rateGuide, rateTrail } = require("../models/trailModel");

exports.saveTrail = async (req, res) => {
  const uid = req.user.uid;
  const { trailId } = req.body;

  console.log("Saving trail for uid:", uid);
  console.log("Trail ID received:", trailId);

  if (!trailId) return res.status(400).json({ error: "trailId is required" });

  try {
    await addSavedTrail(uid, trailId);
    res.status(200).json({ message: "Trail saved successfully" });
  } catch (err) {
    console.error("❌ Error saving trail:", err);
    res.status(500).json({ error: "Could not save trail" });
  }
};


exports.updateItinerary = async (req, res) => {
  const uid = req.user.uid;
  const { itinerary } = req.body;

  if (!Array.isArray(itinerary)) {
    return res.status(400).json({ error: "Invalid itinerary format" });
  }

  try {
    await updateItinerary(uid, itinerary);
    res.status(200).json({ message: "Itinerary updated" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to update itinerary" });
  }
};

exports.selectGuide = async (req, res) => {
  const uid = req.user.uid;
  const { guideId, trailId } = req.body;

  if (!guideId || !trailId) {
    return res.status(400).json({ error: "guideId and trailId are required" });
  }

  try {
    await assignGuide(uid, trailId, guideId);
    res.status(200).json({ message: "Guide selected" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to assign guide" });
  }
};

exports.rateTrail = async (req, res) => {
  const uid = req.user.uid;
  const { trailId, rating, comment } = req.body;

  if (!trailId || rating == null) {
    return res.status(400).json({ error: "trailId and rating are required" });
  }

  try {
    await rateTrail(trailId, { userId: uid, rating, comment, createdAt: Date.now() });
    res.status(200).json({ message: "Trail rated" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to rate trail" });
  }
};

exports.rateGuide = async (req, res) => {
  const uid = req.user.uid;
  const { guideId, rating, comment } = req.body;

  if (!guideId || rating == null) {
    return res.status(400).json({ error: "guideId and rating are required" });
  }

  try {
    await rateGuide(guideId, { userId: uid, rating, comment, createdAt: Date.now() });
    res.status(200).json({ message: "Guide rated" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to rate guide" });
  }
};
exports.getSavedTrails = async (req, res) => {
  const uid = req.user.uid;
  try {
    const user = await getUser(uid);
    res.status(200).json(user?.savedTrails || []);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch saved trails" });
  }
};
exports.getItinerary = async (req, res) => {
  const uid = req.user.uid;
  try {
    const user = await getUser(uid);
    res.status(200).json(user?.itinerary || []);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch itinerary" });
  }
};
