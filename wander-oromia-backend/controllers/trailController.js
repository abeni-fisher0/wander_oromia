const Trail = require("../models/Trail");

// Remove .populate("stops") everywhere
exports.getAllTrails = async (req, res) => {
  try {
    const trails = await Trail.find(); // No populate
    res.json(trails);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch trails" });
  }
};

exports.getTrailsByCategory = async (req, res) => {
  const category = req.params.category;
  try {
    const trails = await Trail.find({ category }); // No populate
    res.json(trails);
  } catch (err) {
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
