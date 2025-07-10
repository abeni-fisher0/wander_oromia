const mongoose = require('mongoose');

const guideSchema = new mongoose.Schema({
  name: String,
  phone: String,
  address: String,
  experience: String,
  languages: [String],
  price: Number,
  trails: [String], // store trailIds
  photoUrl: String,
  userId: String, // auth user id (optional)
});

module.exports = mongoose.model('guide', guideSchema);
