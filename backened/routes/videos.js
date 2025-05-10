const express = require("express");
const {
  upload,
  get_videos,
  get_following_videos,
  videoUpload,
} = require("../controllers/videoController.js");
const { authenticateToken } = require("../middleware/tokenValidation.js");
const parser = require("../services/cloudinary.js");
const videoRouter = express.Router();

//* upload video on cloudinary
videoRouter.post(
  "/cloudinary",
  authenticateToken,
  parser.single("videos"),
  videoUpload
);

//* upload video details on datable
videoRouter.post("/upload", authenticateToken, upload);

//* get all user videos and purchased videos
videoRouter.get("/", authenticateToken, get_videos);

//* get all your following people videos
videoRouter.get("/following", authenticateToken, get_following_videos);

module.exports = videoRouter;
