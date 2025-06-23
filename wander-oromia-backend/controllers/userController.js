const User = require("../models/User");

exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.user.uid).select("name role address email");
    if (!user) return res.status(404).json({ error: "User not found" });

    res.json({
      name: user.name,
      location: user.address || "Unknown",
      role: user.role,
      avatarUrl: `https://api.dicebear.com/7.x/initials/svg?seed=${encodeURIComponent(user.name)}`
    });
  } catch (err) {
    res.status(500).json({ error: "Could not get profile" });
  }
};

exports.updateProfile = async (req, res) => {
  try {
    await User.findByIdAndUpdate(req.user.uid, req.body, { new: true });
    res.json({ message: "Profile updated" });
  } catch (err) {
    res.status(500).json({ error: "Update failed" });
  }
};
