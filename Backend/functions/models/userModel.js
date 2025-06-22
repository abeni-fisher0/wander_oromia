const admin = require("firebase-admin");

if (!admin.apps.length) {
  admin.initializeApp(); 
}

const db = admin.firestore();
const { FieldValue } = require("firebase-admin/firestore");


// 1. Get user data
exports.getUser = async (uid) => {
  const doc = await db.collection("users").doc(uid).get();
  return doc.exists ? doc.data() : null;
};

// 2. Add saved trail
exports.addSavedTrail = async (uid, trailId) => {
  const userRef = db.collection("users").doc(uid);
  return userRef.set({
    savedTrails: FieldValue.arrayUnion(trailId)
  }, { merge: true });
};

// 3. Update itinerary
exports.updateItinerary = async (uid, itinerary) => {
  return db.collection("users").doc(uid).set({ itinerary }, { merge: true });
};

// 4. Select guide for a trail
exports.assignGuide = async (uid, trailId, guideId) => {
  const ref = db.collection("users").doc(uid);
  await ref.set({
    selectedGuides: {
      [trailId]: guideId,
    }
  }, { merge: true });
};

// 5. Update profile
exports.updateUserProfile = async (uid, profileData) => {
  return db.collection("users").doc(uid).set(profileData, { merge: true });
};
