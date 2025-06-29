const UserModel = require("../model/app_user.model");

exports.get_appuser_data=async ()=>{
    try{
     const data= await UserModel.find();
     return data;
    }catch(error){
     throw new Error('fail to fetch data');
     }
};