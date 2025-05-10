const Accounts = require("../models/account.js");
const Wallet = require("../models/wallet.js");

const get_details = async (req, res) => {
  {
    try {
      const id = req.query.id;

      const account = await Accounts.findOne({ userId: id });

      return res.status(200).json([{
        message: "Account Details Retrieved Successfully",
        account,
      }]);
    } catch (e) {
      return res.status(500).json({
        message: e.message,
      });
    }
  }
};

const purchase = async (req, res) => {
  {
    try {
      const {
        id,
        title,
        videoURL,
        videoQuality,
        videoCreator,
        uploadedAt,
        videoPrice,
        upVotes,
        tip,
      } = req.body;

      const account = await Accounts.findOne({ userId: id });

      //* check if user has enough balance
      const wallet = await Wallet.findOne({ userId: id });
      const balance = await wallet.data.balance;

      if (balance < videoPrice) {
        return res.status(400).json({
          message: "You don't have enough balance to purchase this video",
        });
      }

      //* deduct user's balance
      wallet.data.balance -= videoPrice;
      await wallet.save();

      //* add purchased video price in purchased_videos list
      const videoSchema = {
        title,
        videoURL,
        videoQuality,
        videoCreator,
        uploadedAt,
        videoPrice,
        upVotes,
        tip,
      };

      await account.purchased_videos.push(videoSchema);
      await account.save();

      //* increase purchased user's wallet balance
      const creator_wallet = await Wallet.findOne({
        "data.name": videoCreator,
      });
      creator_wallet.data.balance += videoPrice;

      await creator_wallet.save();

      return res.status(200).json({
        message: "Video Purchased Successfully",
      });
    } catch (e) {
      return res.status(500).json({
        message: e.message,
      });
    }
  }
};

const follow = async (req, res) => {
  try {
    const { userName, followName, status } = req.body;

    const current_user = await Accounts.findOne({ name: userName });
    const user = await Accounts.findOne({ name: followName });

    //* Follow an account
    if (status == "Follow") {
      user.followers.push({
        name: userName,
      });

      current_user.following.push({
        name: followName,
      });

      current_user.following_count += 1;
      user.follower_count += 1;

      await user.save();
      await current_user.save();
    } else {
      //* Unfollow an account
      user.followers = user.followers.filter((f) => f.name !== userName);

      current_user.following = current_user.following.filter(
        (f) => f.name !== followName
      );

      current_user.following_count = Math.max(
        current_user.following_count - 1,
        0
      );
      user.follower_count = Math.max(user.follower_count - 1, 0);

      await user.save();
      await current_user.save();
    }

    return res.status(200).json({
      message: `${status} successfully`,
    });
  } catch (e) {
    return res.status(500).json({
      message: e.message,
    });
  }
};

const search = async (req, res) => {
  try {
    const query = req.query.id;

    if (!query) {
      return res.status(400).json({ message: "Query parameter is required" });
    }

    //* Returns all teh users that matches query or starts with query
    const results = await Accounts.find({
      name: { $regex: query, $options: "i" }
    }).select("name email");

    return res.status(200).json(results);
  } catch (e) {
    return res.status(500).json({
      message: e.message,
    });
  }
};

module.exports = { get_details, purchase, follow, search };
