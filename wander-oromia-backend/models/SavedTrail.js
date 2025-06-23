// models/SavedTrail.js
const mongoose = require("mongoose");

const savedTrailSchema = new mongoose.Schema({
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
  role: {
    type: String,
    enum: ["tourist", "guide"],
    required: true,
  },
  savedAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("SavedTrail", savedTrailSchema);
