const Entry_dataService = require('../services/entry_data.services');

exports.entry_data = async(req,res,next)=>{
    try{

        const{car_number,name,entry_date, entry_time}= req.body;

        const sucessRes = await Entry_dataService.entry_data (car_number,name,entry_date, entry_time);

        res.json({status:true,success:"Data Entry done"})

    }catch(error){
        throw error
    }

}