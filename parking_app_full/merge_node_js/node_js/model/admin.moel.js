const db = require('../config/db');
const bcrypt = require("bcrypt"); //to encript password
const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = new Schema({
    first_name: {
        type: String,
        lowercase: true,
       // required: [true, "userName can't be empty"],
        // @ts-ignore
    },
    user_contact_number : {
        type: Number ,
        required: [true, "number can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "number format is not correct",
        ],
        unique: true,
    },
    user_email: {
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
    user_password: {
        type: String,
        required: [true, "password is required"],
    },
},{timestamps:true});
// used while encrypting user entered password
userSchema.pre("save",async function(){
    var user = this;
    if(!user.isModified("user_password")){
        return
    }
    try{
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.user_password,salt);
        user.user_password = hash;
    }catch(error){
        throw error;
    }
});
//used while signIn decrypt
userSchema.methods.comparePassword = async function (candidatePassword) {
    try {
        console.log('----------------no password',this.user_password);
         //@ts-ignore
        const isMatch = await bcrypt.compare(candidatePassword, this.user_password);
        return isMatch;
    } catch (error) {
        throw error;
    }
};
const UserModel = db.model('admins',userSchema);
module.exports = UserModel;
