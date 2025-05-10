const mongoose = require("mongoose");

const f_Schema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
});

const videoSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  videoURL: {
    type: String,
    required: true,
  },
  videoQuality: { type: String, required: true },
  videoCreator: {
    type: String,
    required: true,
  },
  videoPrice: {
    type: Number,
    required: true,
  },
  uploadedAt: {
    type: String,
    required: true,
  },
  upVotes: {
    type: Number,
    required: true,
  },
  tip: {
    type: Number,
    required: true,
  },
});

const accountSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    required: true,
    type: String,
  },
  userId: {
    required: true,
    type: String,
  },
  follower_count: {
    required: true,
    type: Number,
  },
  followers: [f_Schema],
  following_count: {
    required: true,
    type: Number,
  },
  following: [f_Schema],
  purchased_videos: [videoSchema],
});

module.exports = mongoose.model("Accounts", accountSchema);
