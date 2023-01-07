const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth.middleware");

// /products?category=essentials
// /products:category=essentials

productRouter.get("/api/products", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });

    res.status(200).json(products);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

productRouter.post("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });

    res.status(200).json(products);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
