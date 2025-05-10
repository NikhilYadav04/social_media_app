const Wallet = require("../models/wallet.js");

const recharge = async (req, res) => {
  try {
    const { amount, id } = req.body;

    //* Find wallet by userId
    const wallet = await Wallet.findOne({ userId: id });
    if (!wallet) {
      return res.status(404).json({ message: "Wallet not found" });
    }

    //* Update balance
    let current_amount = Number(wallet.data.balance);
    wallet.data.balance = current_amount + Number(amount);

    //* formatted date
    const now = new Date();

    const day = String(now.getDate()).padStart(2, "0");
    const month = now.toLocaleString("en-GB", { month: "short" });
    const year = now.getFullYear();

    const hours = String(now.getHours()).padStart(2, "0");
    const minutes = String(now.getMinutes()).padStart(2, "0");

    const formatted = `${day} ${month} ${year} : ${hours} : ${minutes}`;

    //* Add transaction history
    const history = {
      amountCredited: Number(amount),
      creditedAt: formatted,
    };

    wallet.walletHistories.push(history);

    //* Save wallet
    await wallet.save();

    return res.status(200).json({
      message: "Recharge successful",
      newBalance: wallet.data.balance,
    });
  } catch (e) {
    return res.status(500).json({
      message: `Error : ${e.message}`,
    });
  }
};

const balance = async (req, res) => {
  try {
    const id = req.query.id;

    //* find wallet by userID
    const wallet = await Wallet.findOne({ userId: id });

    //* get balance
    const balance = wallet.data.balance;

    const updatedAt = new Date(wallet.updatedAt).toLocaleDateString("en-GB", {
      day: "2-digit",
      month: "long",
      year: "numeric",
    });

    return res.status(200).json([
      {
        balance: balance,
        history: wallet.walletHistories,
        lastUpdated: updatedAt,
      },
    ]);
  } catch (e) {
    return res.status(500).json({
      message: `Error : ${e.message}`,
    });
  }
};

module.exports = { recharge, balance };
