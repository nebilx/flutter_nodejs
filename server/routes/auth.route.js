const express = require("express");
const authRouter = express.Router();
const auth = require("../middleware/auth.middleware");
const {
  signin,
  signup,
  verifytoken,
  getuserdata,
} = require("../controller/auth.controller");

//SIGNUP
authRouter.post("/api/signup", signup);

//SIGNIN
authRouter.post("/api/signin", signin);

//verifytoken
authRouter.post("/tokenIsValid", verifytoken);

authRouter.get("/", auth, getuserdata);

module.exports = authRouter;
