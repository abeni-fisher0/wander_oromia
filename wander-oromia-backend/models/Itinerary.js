// models/Itinerary.js
const mongoose = require("mongoose");

const itinerarySchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    trailId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Trail",
      required: true,
    },
    stops: [
      {
        stopId: {
          type: mongoose.Schema.Types.ObjectId,
          ref: "Stop",
          required: true,
        },
        day: Number,
        notes: String,
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Itinerary", itinerarySchema);
