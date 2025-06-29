const UserModel = require("../model/user.model");

exports.get_owner_data=async ()=>{
    try{
     const data= await UserModel.find();
     return data;
    }catch(error){
     throw new Error('fail to fetch data');
     }
};