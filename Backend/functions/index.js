const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

app.use("/auth", require("./routes/auth"));
app.use("/tourist", require("./routes/tourist"));
app.use("/guide", require("./routes/guide"));
app.use("/trails", require("./routes/trails"));
app.use("/user", require("./routes/user"));

exports.api = functions.https.onRequest(app);
