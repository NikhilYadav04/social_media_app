const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/User.js");
const Wallet = require("../models/wallet.js");
const Accounts = require("../models/account.js");
const Videos = require("../models/video.js");

exports.register = async (req, res) => {
  try {
    const { name, email, password } = req.body;

    //* Check if user already exists
    let user = await User.findOne({ email });
    if (user) {
      return res.status(401).json({ message: "User already exists" });
    }

    user = await User.findOne({name});
    if (user) {
      return res.status(401).json({ message: "Name is already taken. Please choose a different name." });
    }

    //* Hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    //* Create new user
    user = new User({
      name,
      email,
      password: hashedPassword,
    });

    await user.save();

    //* Create A Wallet Account
    const wallet = new Wallet({
      userId: user._id,
      data: {
        name,
        email,
        balance: 0,
      },
      historySchema: [],
    });

    await wallet.save();

    //* Create User Account
    const acc = new Accounts({
      userId: user._id,
      name,
      email,
      follower_count: 0,
      followers: [],
      following_count: 0,
      following: [],
      purchased_videos: [],
    });

    await acc.save();

    //* create Video Account
    const video = new Videos({
      userId: user._id,
      name: name,
      videos: [],
    });

    await video.save();

    res.status(201).json({
      message: "User registered successfully",
      id: user._id,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};

exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    //* Check if user exists
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    //* Verify password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    //* Create JWT token
    const token = jwt.sign(
      { userId: user._id },
      process.env.JWT_SECRET || "your-secret-key",
      { expiresIn: "1h" }
    );

    res.status(200).json({
      message: "Login successful",
      name : user.name,
      email: user.email,
      id: user._id,
      token,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
};
