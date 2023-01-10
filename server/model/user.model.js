const mongoose = require("mongoose");
const { productSchema } = require("./product.model");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    require: true,
    trim: true,
  },

  email: {
    type: String,
    require: true,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },

  password: {
    type: String,
    require: true,
    trim: true,
    validate: {
      validator: (value) => {
        return value.length > 6;
      },
      message: "Please enter long password",
    },
  },

  address: {
    type: String,
    default: "",
  },

  type: {
    type: String,
    default: "user",
  },

  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = mongoose.model("User", userSchema);

module.exports = User;
