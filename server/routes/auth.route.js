const express = require("express");
const User = require("../model/user");
const authRouter = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
authRouter.get("", (req, res) => {
  res;
});

//SIGNUP
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const userExist = await User.findOne({ email });

    if (userExist) {
      return res.status(400).json({ msg: "User same email already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 8);

    let user = User({
      name,
      email,
      password: hashedPassword,
    });

    user = await user.save();

    return res.status(200).json({ user });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

//SIGNIN
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email doesn't exist" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRECT);

    res.json({ token, ...user._doc });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
