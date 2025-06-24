const fs = require("fs");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const Trail = require("./models/Trail");
const Stop = require("./models/Stop");
const connectDB = require("./config/db");

dotenv.config();

const seed = async () => {
  try {
    await connectDB();

    await Trail.deleteMany();
    await Stop.deleteMany();

    const data = JSON.parse(fs.readFileSync("./data/trails.json", "utf-8"));

    for (const trail of data) {
      const stopDocs = await Stop.insertMany(trail.stops);
      const stopIds = stopDocs.map((stop) => stop._id);
      await Trail.create({ ...trail, stops: stopIds });
    }

    console.log("✅ Trails and Stops seeded successfully.");
    process.exit(0);
  } catch (err) {
    console.error("❌ Seed error:", err);
    process.exit(1);
  }
};

seed();
