const express = require("express");
const dotenv = require("dotenv");
const router = require("./services/router.js");
const cors = require('cors');
const morgan = require('morgan');
const connectDB = require('./services/connectDB.js');

const authRouter = require("./routes/auth.js");
const walletRouter = require("./routes/wallet.js");
const accountRouter = require("./routes/account.js");
const videoRouter = require("./routes/videos.js");

//* Load environment variables
dotenv.config();

const app = express();

//* get
app.get("/", (req, res) => {
  res.send("Server is Live");
});

//* Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(morgan("dev"));
app.use(router);

//* Routes
router.use("/api/v1/user", authRouter);
router.use("/api/v1/wallet",walletRouter);
router.use("/api/v1/account",accountRouter);
router.use("/api/v1/videos",videoRouter);

//* MongoDB connection
connectDB();

//* Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: "Something went wrong!" });
});

const PORT = process.env.PORT || 2000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
