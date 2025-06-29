const UserServices1 = require('../services/owner_data.services');

exports.get_owner_data= async(req, res)=>{
    try{
        const data = await UserServices1.get_owner_data();
        res.json(data);
    }catch(error){
        res.status(500).json({error:error.message});
    }
};