// app.js
const express = require("express");
const connectDB = require("./config/db");
const cors = require("cors");
const dotenv = require("dotenv");

dotenv.config();
connectDB();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Route files
const authRoutes = require("./routes/authRoutes");
app.use("/api/auth", authRoutes);
app.use("/api/users", require("./routes/userRoutes"));
app.use("/api/trails", require("./routes/trailRoutes"));
app.use("/api/stops", require("./routes/stopRoutes"));
app.use("/api/saved", require("./routes/savedTrailRoutes"));
app.use("/api/itineraries", require("./routes/itineraryRoutes"));
app.use('/api/guides', require('./routes/guideRoutes'));
app.use("/api/bookings", require("./routes/bookings"));


// Default root route
app.get("/", (req, res) => {
  res.send("🌍 Wander Oromia Backend is running...");
});

module.exports = app;
