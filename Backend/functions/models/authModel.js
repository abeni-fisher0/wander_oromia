const admin = require("firebase-admin");
const db = admin.firestore();

exports.setUserInfo = async (uid, role, username) => {
  return db.collection("users").doc(uid).set({
    role,
    username,
    createdAt: Date.now()
  }, { merge: true });
};
