const { getAllTrails, getTrailById } = require("../models/trailModel");

exports.getAll = async (req, res) => {
  try {
    const trails = await getAllTrails();
    res.status(200).json(trails);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Could not fetch trails" });
  }
};

exports.getOne = async (req, res) => {
  const { trailId } = req.params;

  try {
    const trail = await getTrailById(trailId);
    if (!trail) return res.status(404).json({ error: "Trail not found" });
    res.status(200).json(trail);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch trail" });
  }
};
