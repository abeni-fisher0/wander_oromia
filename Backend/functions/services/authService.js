const { setUserRole } = require("../models/authModel");

exports.registerUser = async (req, res) => {
  const uid = req.user.uid;
  const { role } = req.body;

  if (!role) return res.status(400).json({ error: "role is required" });

  try {
    await setUserRole(uid, role);
    res.status(200).json({ message: "User registered with role" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to set role" });
  }
};
