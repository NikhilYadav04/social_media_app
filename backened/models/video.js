const mongoose = require("mongoose");

const tipperSchema = new mongoose.Schema({
  tipper: {
    type: String,
    required: true,
  },
  tipAmount: {
    type: Number,
    required: true,
  },
  tippedBy: {
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
  videoCreator: {
    type: String,
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
  upVotesBy: [
    {
      type: String,
      required: true,
    },
  ],
  tip: {
    type: Number,
    required: true,
  },
  tippers: [tipperSchema],
});

const videoUserSchema = new mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  videos: [videoSchema],
});

module.exports = mongoose.model("Videos", videoUserSchema);
