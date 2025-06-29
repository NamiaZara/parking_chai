const Exit_dataModel = require('../model/exit_data.model')

class Exit_dataService{
    static async exit_data (userID, car_number, exit_date, exit_time){
        try{
              const exitdata_entry = new Exit_dataModel({userID, car_number, exit_date, exit_time});
              return await exitdata_entry.save();

        }catch(err){
            throw err;

        }
    }

    /*static async getExit_data(userId){
        const exitData = await Exit_dataModel.find({userId})
        return exitData;
    }*/

}
module.exports = Exit_dataService;