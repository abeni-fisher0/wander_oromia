const { getUser, updateUserProfile } = require("../models/userModel");

exports.getProfile = async (req, res) => {
  const uid = req.user.uid;

  try {
    const user = await getUser(uid);
    if (!user) return res.status(404).json({ error: "User not found" });
    res.status(200).json(user);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Could not get user profile" });
  }
};

exports.updateProfile = async (req, res) => {
  const uid = req.user.uid;
  const data = req.body;

  try {
    await updateUserProfile(uid, data);
    res.status(200).json({ message: "Profile updated" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Update failed" });
  }
};
