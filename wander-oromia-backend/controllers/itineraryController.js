const Itinerary = require("../models/Itinerary");

exports.createItinerary = async (req, res) => {
  try {
    const itinerary = await Itinerary.create({
      userId: req.user.uid,
      ...req.body,
    });
    res.status(201).json(itinerary);
  } catch (err) {
    res.status(500).json({ error: "Could not create itinerary" });
  }
};

exports.getMyItineraries = async (req, res) => {
  try {
    const itineraries = await Itinerary.find({ userId: req.user.uid }).populate(
      "trailId stops.stopId"
    );
    res.json(itineraries);
  } catch (err) {
    res.status(500).json({ error: "Failed to fetch itineraries" });
  }
};
