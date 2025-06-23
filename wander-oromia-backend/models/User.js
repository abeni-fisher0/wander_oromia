// models/User.js
const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    role: {
      type: String,
      enum: ["tourist", "guide"],
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    email: {
      type: String,
      unique: true,
      lowercase: true,
      required: true,
    },
    passwordHash: {
      type: String,
      required: true,
    },
    phone: String,
    address: String,
    experience: String, // Only for guides
  },
  { timestamps: true }
);

module.exports = mongoose.model("User", userSchema);
