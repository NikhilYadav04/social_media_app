const express = require('express');
const walletRouter = express.Router();
const { authenticateToken } = require("../middleware/tokenValidation.js");
const {recharge , balance} = require('../controllers/walletController.js');

//* recharge wallet
walletRouter.post("/recharge", authenticateToken, recharge);

//* get recharge
walletRouter.get("/get-balance", authenticateToken, balance);

module.exports = walletRouter;
