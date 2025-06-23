// models/Trail.js
const mongoose = require("mongoose");

const trailSchema = new mongoose.Schema(
  {
    title: { type: String, required: true },
    category: {
      type: String,
      enum: ["Festivals", "Food & Cuisine", "Nature & Eco", "Wildlife"],
      required: true,
    },
    description: { type: String },
    imageUrl: { type: String }, // relative or full URL
    stops: [{ type: mongoose.Schema.Types.ObjectId, ref: "Stop" }],
  },
  { timestamps: true }
);

module.exports = mongoose.model("Trail", trailSchema);
