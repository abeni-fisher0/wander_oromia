const SavedTrail = require("../models/SavedTrail");

exports.saveTrail = async (req, res) => {
  try {
    const { trailId } = req.body;
    const saved = await SavedTrail.create({
      userId: req.user.uid,
      trailId,
      role: req.user.role,
    });
    res.status(201).json(saved);
  } catch (err) {
    res.status(500).json({ error: "Could not save trail" });
  }
};

exports.getSavedTrails = async (req, res) => {
  try {
    const saved = await SavedTrail.find({ userId: req.user.uid }).populate(
      "trailId"
    );
    res.json(saved);
  } catch (err) {
    res.status(500).json({ error: "Could not get saved trails" });
  }
};
