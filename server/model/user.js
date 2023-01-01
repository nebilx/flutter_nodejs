const mongoose = require('mongoose');

const userSchema = mongoose.Schema({

    name: {
        typeof: String,
        require: true,
        trim: true,
    },
    email: {
        typeof: String,
        require: true,
        trim: true,
        validate: {
            validator: (value) => {
                const re = ''
              return  value.match(re);
            },
            message : 'Please enter a valid email address',
        },
    },
    password: {
        typeof: String,
        require: true,
        trim: true,
        validate: {
            validator: (value) => {
               
              return  value.length > 6 ;
            },
            message : 'Please enter long password',
        },
    },
    address: {
        typeof: String,
       default: '',
    },
    type: {
        typeof: String,
       default: 'user',
    },
//cart
});

const User = mongoose.model('User', userSchema);

module.exports = User;