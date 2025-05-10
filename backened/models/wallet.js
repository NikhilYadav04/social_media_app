const mongoose = require("mongoose");

const dataSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  balance: {
    type: Number,
    required: true,
  },
});

const historySchema = new mongoose.Schema({
  amountCredited: {
    type: Number,
    required: true,
  },
  creditedAt: {
    type: String,
    required: true,
  },
});

const walletSchema = new mongoose.Schema(
  {
    userId: {
      type: String,
      required: true,
    },
    data: dataSchema,
    walletHistories: [historySchema],
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Wallet", walletSchema);
