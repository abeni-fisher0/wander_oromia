const mongoose = require('mongoose');
const Trail = require('../models/Trail');
const Stop = require('../models/Stop');
const dotenv = require('dotenv');
const fs = require('fs');

dotenv.config();

const connect = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log('✅ MongoDB connected');
  } catch (err) {
    console.error('❌ Connection failed:', err);
    process.exit(1);
  }
};

const importData = async () => {
  try {
    const file = fs.readFileSync('./data/trails.json', 'utf-8');
    const trails = JSON.parse(file);

    for (const t of trails) {
      const createdTrail = await Trail.create({
        title: t.title,
        category: t.category,
        description: t.description,
        imageUrl: t.imageUrl,
      });

      console.log(`📍 Created trail: ${createdTrail.title} (ID: ${createdTrail._id})`);

      for (const s of t.stops) {
        const stop = await Stop.create({
          trailId: createdTrail._id,
          name: s.name,
          description: s.description,
          images: s.images || [],
          videos: s.videos || [],
          location: s.location || {},
        });

        console.log(`   🛑 Added stop: ${stop.name} (Trail ID: ${createdTrail._id})`);
      }

      console.log(`✅ Finished importing trail: ${t.title}`);
      console.log('------------------------------------------');
    }

    console.log('🎉 All trails and stops imported successfully!');
    process.exit();
  } catch (err) {
    console.error('❌ Error importing data:', err);
    process.exit(1);
  }
};

connect().then(importData);
