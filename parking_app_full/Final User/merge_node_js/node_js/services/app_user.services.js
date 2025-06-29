const UserModel = require("../model/app_user.model");
const jwt = require("jsonwebtoken");
class UserServices{
 
    static async registerUser(first_name,last_name,user_contact_number,user_email,user_password){
        try{
                //console.log("-----Email --- Password-----",email,password);
                
                const createUser = new UserModel({first_name,last_name,user_contact_number,user_email,user_password});
                return await createUser.save();
        }catch(err){
            throw err;
        }
    }
    static async getUserByEmail(user_email){
       try{
            return await UserModel.findOne({user_email});
       }catch(err){
           console.log(err);
        }
   }
    static async checkUser(user_email){
        try {
           return await UserModel.findOne({user_email});
        } catch (error) {
            throw error;
        }
    }
    static async generateAccessToken(tokenData,JWTSecret_Key,JWT_EXPIRE){
        return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
    }

    // static async getprofile(user_email){
       
    //             const profiledata = await UserModel.find({user_email});
    //             return profiledata;
        
    // }
}
module.exports = UserServices;