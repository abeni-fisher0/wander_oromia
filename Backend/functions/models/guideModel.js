const admin = require("firebase-admin");

if (!admin.apps.length) {
  admin.initializeApp(); 
}

const db = admin.firestore();
const { FieldValue } = require("firebase-admin/firestore");

// 1. Create or update guide profile
exports.uploadGuideProfile = async (uid, data) => {
  return db.collection("guides").doc(uid).set(data, { merge: true });
};

// 2. Join trail
exports.registerTrail = async (uid, trailId) => {
  return db.collection("guides").doc(uid).set({
    registeredTrails: FieldValue.arrayUnion(trailId)
  }, { merge: true });
};

// 3. Get guide data
exports.getGuideProfile = async (uid) => {
  const doc = await db.collection("guides").doc(uid).get();
  return doc.exists ? doc.data() : null;
};
