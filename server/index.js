const express =  require('express');
const PORT =3000;
const DB = '';
const app = express();
const mongoose = require('mongoose');

const authRouter = require('./routes/auth.route');

app.use(authRouter);
app.use(express.json);

mongoose.connect(DB).then(()=> {
    console.log('connection successfull');
})
.catch((e) => {
    console.log(e);
})

app.listen(PORT, () => {
console.log(`connected at ${PORT}`)
})