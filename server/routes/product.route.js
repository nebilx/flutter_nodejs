const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth.middleware");
const { Product } = require("../model/product.model");

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

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});

    // A -> 10
    // B -> 30
    // C -> 50
    //calculate total point of all
    // a and b product a and product b
    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        (aSum += a.ratings[i]), rating;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        (bSum += b.ratings[i]), rating;
      }

      return aSum < bSum ? 1 : -1;
    });

    res.status(200).json(products[0]);
  } catch (error) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
