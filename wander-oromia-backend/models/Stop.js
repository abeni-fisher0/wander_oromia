// models/Stop.js
const mongoose = require("mongoose");

const stopSchema = new mongoose.Schema(
  {
    trailId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Trail",
      required: true,
    },
    name: { type: String, required: true },
    description: String,
    images: [String],
    videos: [String],
    location: {
      lat: Number,
      lng: Number,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Stop", stopSchema);
