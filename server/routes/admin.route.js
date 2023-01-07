const e = require("express");
const express = require("express");
const adminRoute = express.Router();
const admin = require("../middleware/admin.middleware");
const Product = require("../model/product.model");
const User = require("../model/user.model");
//Add product
adminRoute.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, quantity, price, category, images } = req.body;
    console.log("it reach here");
    console.log(req.body);

    let product = new Product({
      name,
      description,
      quantity,
      price,
      category,
      images,
    });

    product = await product.save();

    console.log("to database");
    console.log(product);

    return res.status(200).json({ product });
  } catch (error) {
    return res.status(500).json({ error: e.message });
  }
});

adminRoute.get("/admin/get-product", admin, async (req, res) => {
  try {
    const products = await Product.find({});

    res.status(200).json(products);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

adminRoute.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await User.findByIdAndDelete(id);
    return res.status(200).json(product);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});
module.exports = adminRoute;
