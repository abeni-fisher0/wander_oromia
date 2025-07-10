const mongoose = require("mongoose");


const bookingSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  guideId: { type: mongoose.Schema.Types.ObjectId, ref: "guide", required: true },
  trailId: { type: mongoose.Schema.Types.ObjectId, ref: "Trail", required: true },
  itineraryId: { type: mongoose.Schema.Types.ObjectId, ref: "Itinerary" },
  date: { type: Date, required: true },
  notes: String,
}, { timestamps: true });

module.exports = mongoose.model("Booking", bookingSchema);
