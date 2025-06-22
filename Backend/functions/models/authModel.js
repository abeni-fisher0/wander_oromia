const admin = require("firebase-admin");
const db = admin.firestore();

exports.setUserRole = async (uid, role) => {
  return db.collection("users").doc(uid).set({ role }, { merge: true });
};

exports.getUserRole = async (uid) => {
  const doc = await db.collection("users").doc(uid).get();
  return doc.exists ? doc.data().role : null;
};
