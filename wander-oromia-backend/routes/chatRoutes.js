const express = require("express");
const router = express.Router();
const chatController = require("../controllers/chatController");

// Send a new message
router.post("/", chatController.sendMessage);

// Get conversation between two users
router.get("/:user1/:user2", chatController.getConversation);

module.exports = router;
