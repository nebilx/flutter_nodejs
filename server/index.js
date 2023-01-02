require("dotenv").config();

const express = require("express");
const PORT = process.env.PORT || 3500;
const app = express();
const mongoose = require("mongoose");
const connectDB = require("./config/db.config");
const authRouter = require("./routes/auth.route");

//connect to MongoDB
connectDB();

// built-in middleware for json
app.use(express.json());
// built-in middleware to handle urlencoded form data
// extended true allow to send nested object like
// Nested Object = { person: { name: cw } }
// extended false u can't post nested object
app.use(express.urlencoded({ extended: false }));

app.use(authRouter);

app.listen(PORT, () =>
  console.log(`Server running at http://localhost:${PORT}`)
);

// mongoose.connection.once("open", () => {
//   app.listen(PORT, () =>
//     console.log(`Server running at http://localhost:${PORT}`)
//   );
// });