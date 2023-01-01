const express = require('express');
const User = require('../model/user');
const authRouter =  express.Router();
const bcrypt = require('bcrypt');

authRouter.get( '' , (req,res) =>{
res
})


//SIGNUP
authRouter.post('/api/signup', async (req, res) =>  {

    try {
        const {name, email,password} = req.body;

   const userExist =  await User.findOne({email});

   if(userExist) {
 return res.status(400).json({msg : 'User same email already exists'});
   }

  const hashedPassword = await bcrypt.hash(password, 8);

   let user = User ({
    name,
    email,
    hashedPassword,
   });

   user = await user.save();

   return res.status(200).json({user});
    }
    catch(e) {
        console.log(e);
    }
});

module.exports = authRouter;