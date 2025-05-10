const mongoose = require('mongoose');
const dotenv = require('dotenv');

dotenv.config();

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.DB, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("✅ Connected to MongoDB");
  } catch (e) {
    console.error("❌ MongoDB Connection Error:", e.message);
    process.exit(1);
  }
};

module.exports = connectDB;
