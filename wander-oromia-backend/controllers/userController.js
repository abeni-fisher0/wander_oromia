const User = require("../models/User");

// userController.js

exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.user.uid).select(
      "name role address email avatarUrl phone savedTrails itinerary"
    );
    if (!user) return res.status(404).json({ error: "User not found" });

    res.json({
      _id: user._id,
      fullName: user.name, // ✅ FIXED
      email: user.email,
      phone: user.phone,
      role: user.role,
      address: user.address || "Unknown",
      avatarUrl: user.avatarUrl,
      savedTrails: user.savedTrails || [],
      itinerary: user.itinerary || [],
    });
  } catch (err) {
    res.status(500).json({ error: "Could not get profile" });
  }
};

exports.updateProfile = async (req, res) => {
  try {
    const updatedUser = await User.findByIdAndUpdate(req.user.uid, req.body, {
      new: true,
    });
    res.json({ message: "Profile updated", user: updatedUser });
  } catch (err) {
    res.status(500).json({ error: "Update failed" });
  }
};

exports.uploadAvatar = async (req, res) => {
  try {
    if (!req.file)
      return res.status(400).json({ error: "No image file provided" });

    const avatarUrl = `${req.protocol}://${req.get("host")}/uploads/${
      req.file.filename
    }`;

    await User.findByIdAndUpdate(req.user.uid, { avatarUrl });

    res.status(200).json({ avatarUrl });
  } catch (err) {
    console.error("Avatar upload failed:", err);
    res.status(500).json({ error: "Avatar upload failed" });
  }
};
