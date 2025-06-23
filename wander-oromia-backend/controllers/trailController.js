const Trail = require("../models/Trail");

exports.getAllTrails = async (req, res) => {
  try {
    const trails = await Trail.find().populate("stops");
    res.json(trails);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch trails" });
  }
};

exports.createTrail = async (req, res) => {
  try {
    const trail = await Trail.create(req.body);
    res.status(201).json(trail);
  } catch (err) {
    res.status(500).json({ error: "Trail creation failed" });
  }
};
