const UserServices = require('../services/user_data.services');

exports.get_appuser_data= async(req, res)=>{
    try{
        const data = await UserServices.get_appuser_data();
        res.json(data);
    }catch(error){
        res.status(500).json({error:error.message});
    }
};