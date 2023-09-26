const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcrypt');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');

// SIGN UP

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password } = req.body;
        const existingUser = await User.findOne({ email: email });
        if (existingUser) {
            res.status(400).json({ msg: 'Usuario con el mismo email ya existe' });
        }
        const hashedPassword = await bcrypt.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

    //get data from client
    //post data in database
    //return data to the user
});

// authRouter.get('/user', (req, res) =>{
//     res.json({nombre:'gustavo'});
// });

// SIGN IN ROUTE

authRouter.post('/api/signin', async(req,res)=>{
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email: email});
        if(!user){
            return res.status(400).json({msg: 'El usuario con este correo no existe'});
        }
      const isMatch =  await bcrypt.compare(password, user.password);
      if(!isMatch){
        return res.status(400).json({msg: 'La contraseña es incorrecta'})
      }
     const token = jwt.sign({id:user._id}, "passwordKey");
     res.json({token, ...user._doc});
    } catch(e){
        res.status(500).json({error : message});
    }
})



module.exports = authRouter;