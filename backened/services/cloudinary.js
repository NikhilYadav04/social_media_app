const multer = require("multer");
const cloudinary = require("cloudinary").v2;
const { CloudinaryStorage } = require("multer-storage-cloudinary");
require("dotenv").config();

//* Configure Cloudinary
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

//* Set up Cloudinary storage for videos
const storage = new CloudinaryStorage({
  cloudinary,
  params: async (req, file) => ({
    folder: "social_videos",
    resource_type: "video",
    format: "mp4",
    upload_preset: "e_items", // <-- add this
    public_id: file.originalname.split(".")[0],
  }),
});

const parser = multer({ storage });

module.exports = parser;
