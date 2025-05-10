const express = require("express");
const {
  get_details,
  purchase,
  follow,
  search
} = require("../controllers/accoutnController.js");
const { authenticateToken } = require("../middleware/tokenValidation.js");
const accountRouter = express.Router();

//* get account details
accountRouter.get("/", authenticateToken, get_details);

//* purchase an video
accountRouter.post("/purchase", authenticateToken, purchase);

//*follow or unfollow and account
accountRouter.post("/follow",authenticateToken,follow);

//* search for accounts
accountRouter.get("/search",authenticateToken,search)

module.exports = accountRouter;
