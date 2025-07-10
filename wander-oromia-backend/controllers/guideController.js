const Guide = require("../models/guide");

// POST /api/guides
exports.createGuide = async (req, res) => {
  try {
    const {
      name,
      phone,
      address,
      experience,
      languages,
      price,
      trails,
      userId,
    } = req.body;

    const photoUrl = req.file?.path;

    console.log("🟢 Received fields:");
    console.log("name:", name);
    console.log("phone:", phone);
    console.log("address:", address);
    console.log("experience:", experience);
    console.log("languages (raw):", languages);
    console.log("price:", price);
    console.log("trails (raw):", trails);
    console.log("userId:", userId);
    console.log("photo path:", photoUrl);

    // Parse arrays safely
    let parsedLanguages, parsedTrails;
    try {
      parsedLanguages = JSON.parse(languages);
      parsedTrails = JSON.parse(trails);
    } catch (jsonErr) {
      console.error("❌ JSON parse error:", jsonErr.message);
      return res
        .status(400)
        .json({ error: "Invalid JSON in languages or trails" });
    }

    const guide = new Guide({
      name,
      phone,
      address,
      experience,
      languages: parsedLanguages,
      price,
      trails: parsedTrails,
      photoUrl,
      userId,
    });

    await guide.save();

    console.log("✅ Guide saved successfully");
    res.status(201).json(guide);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to save guide info" });
  }
};

// GET /api/guides
exports.getAllGuides = async (req, res) => {
  const guides = await Guide.find();
  res.json(guides);
};

// GET /api/guides/trail/:trailId
exports.getGuidesByTrail = async (req, res) => {
  const trailId = req.params.trailId;
  const guides = await Guide.find({ trails: trailId });
  res.json(guides);
};

exports.getSavedTrailsByUser = async (req, res) => {
  try {
    const userId = req.params.userId;

    const guide = await Guide.findOne({ userId }).populate({
      path: "trails",
      model: "Trail",
    });

    if (!guide) return res.status(404).json({ error: "Guide not found" });

    res.status(200).json(guide.trails);
  } catch (err) {
    console.error("❌ Error fetching saved trails:", err);
    res.status(500).json({ error: "Server error" });
  }
};