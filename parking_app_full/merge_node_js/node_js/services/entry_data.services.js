const entry_dataModel = require('../model/entry_data.model')

class Entry_dataService{
    static async entry_data (car_number,name,entry_date, entry_time){
        try{
              const dataentry = new entry_dataModel({car_number,name,entry_date, entry_time});
              return await dataentry.save();

        }catch(err){
            throw err;

        }
            
    }

}
module.exports = Entry_dataService;