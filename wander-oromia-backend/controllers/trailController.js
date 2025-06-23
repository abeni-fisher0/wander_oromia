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
// controllers/trailController.js
exports.getTrailsByCategory = async (req, res) => {
  const category = req.params.category;

  try {
    const trails = await Trail.find({ category }).populate("stops");
    if (!trails.length) {
      return res.status(404).json({ message: "No trails found for this category." });
    }
    res.json(trails);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch trails by category" });
  }
};

// controllers/trailController.js
exports.searchTrails = async (req, res) => {
  const query = req.query.query;

  try {
    const trails = await Trail.find({
      $or: [
        { title: { $regex: query, $options: "i" } },
        { description: { $regex: query, $options: "i" } },
        { category: { $regex: query, $options: "i" } },
      ],
    }).populate("stops");

    if (!trails.length) {
      return res.status(404).json({ message: "No matching trails found." });
    }

    res.json(trails);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Trail search failed" });
  }
};
