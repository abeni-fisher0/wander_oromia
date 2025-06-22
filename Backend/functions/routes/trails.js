const express = require("express");
const router = express.Router();
const { getAll, getOne } = require("../services/trailService");

router.get("/", getAll);                  // GET /trails
router.get("/:trailId", getOne);          // GET /trails/:trailId

module.exports = router;
