const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth.middleware");
const Product = require("../model/product.model");

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

// get post to search
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });

    res.status(200).json(products);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// create post request route to rate the product
productRouter.get("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;

    let product = await Product.findById(id);

    for (let i = 0; i < product.rating.length; i++) {
      if (product.rating[i].userId == req.user) {
        //splice to delete product
        product.rating.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.rating.push(ratingSchema);

    product = await product.save();
    req.json(product);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
