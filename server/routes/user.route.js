const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth.middleware");
const { Product } = require("../model/product.model");
const User = require("../model/user.model");

userRouter.post("/api/add-product", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(id)) {
          isProductFound = true;
        }
      }
      if (isProductFound) {
        let producttt = user.cart.find((productt) =>
          productt.product._id.equals(product._id)
        );

        producttt.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }

    user = await user.save();
    res.json(user);
  } catch (error) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
