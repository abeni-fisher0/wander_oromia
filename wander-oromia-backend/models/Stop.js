// models/Stop.js
const mongoose = require("mongoose");

const stopSchema = new mongoose.Schema({
  name: String,
  description: String,
  images: [String],
  videos: [String],
  location: {
    lat: Number,
    lng: Number,
  },
  trailId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Trail',
    required: true,
  },
});


module.exports = mongoose.model("Stop", stopSchema);
