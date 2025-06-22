const { setUserInfo } = require("../models/authModel");

exports.registerUser = async (req, res) => {
  const uid = req.user.uid;
  const { role, username } = req.body;
  if (!role || !username) return res.status(400).json({ error: "Missing fields" });

  await setUserInfo(uid, role, username);
  res.status(200).json({ message: "User registered with role and username" });
};

