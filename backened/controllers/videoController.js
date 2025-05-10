const Accounts = require("../models/account.js");
const Videos = require("../models/video.js");

const upload = async (req, res) => {
  try {
    const { userId, videoURL, title, videoCreator } = req.body;

    //* find video account of user
    const video = await Videos.findOne({ userId });

    const date = new Date().toLocaleDateString("en-GB", {
      day: "2-digit",
      month: "long",
      year: "numeric",
    });

    //* add the video to list
    const videoSchema = {
      title,
      videoURL,
      videoCreator,
      uploadedAt: date,
      upVotes: "0",
      upVotesBy: [],
      tip: "0",
      tippers: [],
    };

    await video.videos.push(videoSchema);
    await video.save();

    return res.status(200).json({
      message: "Video Uploaded Successfully",
    });
  } catch (e) {
    return res.status(500).json({
      message: `Error : ${e.message}`,
    });
  }
};

const get_videos = async (req, res) => {
  try {
    const id = req.query.id;

    //* get all user videos and purchased videos
    console.log(id);
    const acc = await Accounts.findOne({ userId: id });

    const purchased_videos = acc.purchased_videos;

    const user = await Videos.findOne({ userId: id });

    const user_videos = user.videos;

    return res.status(200).json([
      {
        purchased_videos,
        user_videos,
      },
    ]);
  } catch (e) {
    return res.status(500).json({
      message: `Error : ${e.message}`,
    });
  }
};

const get_following_videos = async (req, res) => {
  try {
    const id = req.query.id;

    //* get all following user list's videos
    const user = await Accounts.findOne({ userId: id });
    const following = await user.following;

    let videos_list = [];
    let following_list = [];

    for (let i = 0; i < user.following.length; i++) {
      following_list.push(following[i]["name"]);
    }

    for (let i = 0; i < following.length; i++) {
      const user_videos = await Videos.findOne({ name: following[i]["name"] });

      if (user_videos && user_videos.videos) {
        videos_list.push(...user_videos.videos);
      }
    }

    return res.status(200).json([
      {
        list: videos_list,
        followers: user.followers,
        following: following_list,
      },
    ]);
  } catch (e) {
    return res.status(500).json({
      message: `Error : ${e.message}`,
    });
  }
};

const videoUpload = async (req, res) => {
  try {
    if (!req.file || !req.file.path) {
      return res.status(400).json({ error: "No file uploaded" });
    }
    return res.status(200).json({ secure_url: req.file.path });
  } catch (err) {
    console.error("Upload error:", err);
    return res.status(500).json({ error: "Upload failed" });
  }
};

module.exports = { upload, get_videos, get_following_videos,videoUpload };
