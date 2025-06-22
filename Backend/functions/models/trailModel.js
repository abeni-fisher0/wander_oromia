const admin = require("firebase-admin");
const db = admin.firestore();

// 1. Get all trails
exports.getAllTrails = async () => {
  const snapshot = await db.collection("trails").get();
  return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
};

// 2. Get a single trail
exports.getTrailById = async (trailId) => {
  const doc = await db.collection("trails").doc(trailId).get();
  return doc.exists ? doc.data() : null;
};

// 3. Rate a trail
exports.rateTrail = async (trailId, ratingData) => {
  return db.collection("trails").doc(trailId).collection("ratings").add(ratingData);
};

// 4. Rate a guide
exports.rateGuide = async (guideId, ratingData) => {
  return db.collection("guides").doc(guideId).collection("ratings").add(ratingData);
};
