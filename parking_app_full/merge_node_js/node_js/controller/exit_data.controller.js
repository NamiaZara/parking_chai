const Exit_dataService = require('../services/exit_data.services')

// Existing route to handle exit_data
exports.exit_data = async (req, res, next) => {
    try {
        const {userID, car_number, exit_date, exit_time } = req.body;

        // Update the document in the database
        let exit_data = await Exit_dataService.exit_data (userID, car_number, exit_date, exit_time);
        res.json({status:true, success:exit_data})
    } catch (error) {
        res.status(500).json({ status: false, error: 'Data not entered' });
    }
    
};
/*exports.getExit_data= async(req, res)=>{
    try{
        const {userID} = req.body;
        let exitData = await Exit_dataService.getExit_data(userID);
        res.json({status:true, success:exitData})
    }catch(error){
        res.status(500).json({error:error.message});
    }
};*/
