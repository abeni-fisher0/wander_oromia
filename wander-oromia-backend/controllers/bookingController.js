const Booking = require("../models/Booking");
require("../models/guide");
require("../models/Trail");

exports.createBooking = async (req, res) => {
  try {
    const { userId, guideId, trailId, itineraryId, date, notes } = req.body;

    const booking = new Booking({
      userId,
      guideId,
      trailId,
      itineraryId,
      date,
      notes
    });

    await booking.save();
    res.status(201).json(booking);
  } catch (err) {
    console.error("Booking error:", err);
    res.status(500).json({ error: "Failed to create booking" });
  }
};

exports.getUserBookings = async (req, res) => {
  try {
    const bookings = await Booking.find({ userId: req.params.userId })
      .populate("guideId")
      .populate("trailId");

    res.json(bookings);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to fetch bookings" });
  }
};

