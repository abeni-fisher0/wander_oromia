const mongoose = require('mongoose');

const itinerarySchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  trailId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Trail',
  },
  startDate: Date,
  days: Number,
  interests: [String],
  stops: [
    {
      stopId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Stop',
      },
      day: Number,
      notes: String,
    },
  ],
}, { timestamps: true });

module.exports = mongoose.model('Itinerary', itinerarySchema);
