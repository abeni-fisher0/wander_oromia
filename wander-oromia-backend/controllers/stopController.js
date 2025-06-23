const Stop = require("../models/Stop");

exports.getStopsByTrail = async (req, res) => {
  try {
    const trailId = req.params.trailId;
    const stops = await Stop.find({ trailId });
    res.json(stops);
  } catch (err) {
    res.status(500).json({ error: "Could not get stops" });
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
