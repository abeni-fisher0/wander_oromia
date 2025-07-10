const Trail = require("../models/Trail");
const Stop = require("../models/Stop");

exports.getAllStops = async (req, res) => {
  try {
    const stops = await Stop.find();
    res.json(stops);
  } catch (err) {
    console.error('❌ Error fetching all stops:', err);
    res.status(500).json({ error: 'Failed to fetch stops' });
  }
};


exports.getStopsByTrailTitle = async (req, res) => {
  try {
    const { trailTitle } = req.params;
    const trail = await Trail.findOne({ title: trailTitle });

    if (!trail) {
      return res.status(404).json({ error: 'Trail not found' });
    }

    const stops = await Stop.find({ trailId: trail._id });
    res.json(stops);
  } catch (err) {
    res.status(500).json({ error: 'Error fetching stops' });
  }
};
exports.getStopsByTrail = async (req, res) => {
  try {
    const trailId = req.params.trailId;
    const stops = await Stop.find({ trailId });
    res.json(stops);
  } catch (err) {
    res.status(500).json({ error: "Could not get stops" });
  }
};
exports.getStopsByTrailId = async (req, res) => {
  try {
    const trailId = req.params.trailId;

    const stops = await Stop.find({ trailId });

    if (!stops || stops.length === 0) {
      return res.status(404).json({ error: "No stops found for this trail" });
    }

    res.json(stops);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error" });
  }
};
exports.createStop = async (req, res) => {
  try {
    const stop = await Stop.create(req.body);
    res.status(201).json(stop);
  } catch (err) {
    res.status(500).json({ error: "Stop creation failed" });
  }
};
exports.getStopByName = async (req, res) => {
  try {
    const decodedName = decodeURIComponent(req.params.name);
    const stop = await Stop.findOne({ name: decodedName });

    if (!stop) return res.status(404).json({ error: 'Stop not found' });
    res.json(stop);
  } catch (err) {
    console.error('❌ getStopByName error:', err);
    res.status(500).json({ error: 'Server error' });
  }
};
