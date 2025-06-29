const db = require('../config/db');
const bcrypt = require("bcrypt"); //to encript password
const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = new Schema({
    name: {
        type: String,
        lowercase: true,
       // required: [true, "userName can't be empty"],
        // @ts-ignore
    },
    address: {
        type: String,
        lowercase: true,
        required: [true, "address can't be empty"],
        // @ts-ignore
        
    },
    location: {
        type: String,
        lowercase: true,
        required: [true, "location can't be empty"],
        // @ts-ignore
        
    },
    contact_number : {
        type: Number ,
        required: [true, "number can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "number format is not correct",
        ],
        unique: true,
    },
    parking_space_number: {
        type: Number,
        required: [true, "space can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
    },
    per_hour_cost: {
        type: Number,
        required: [true, "cost can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
    },
    email: {
        type: String,
        lowercase: true,
        required: [true, "userName can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "password is required"],
    },
},{timestamps:true});
// used while encrypting user entered password
userSchema.pre("save",async function(){
    var user = this;
    if(!user.isModified("password")){
        return
    }
    try{
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.password,salt);
        user.password = hash;
    }catch(error){
        throw error;
    }
});
//used while signIn decrypt
userSchema.methods.comparePassword = async function (candidatePassword) {
    try {
        console.log('----------------no password',this.password);
         //@ts-ignore
        const isMatch = await bcrypt.compare(candidatePassword, this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
};
const UserModel = db.model('parking_owners',userSchema);
module.exports = UserModel;
