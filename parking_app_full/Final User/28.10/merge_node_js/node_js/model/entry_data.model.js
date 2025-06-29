const mongoose = require('mongoose');
const db = require('../config/db');
const UserModel = require('../model/user.model');
const { Schema } = mongoose;

const entry_dataSchema = new Schema({

   userID:{
        type: Schema.Types.ObjectID,
        ref: UserModel.modelName,
    },

    car_number:{
        type:String,
        required: true,
    },

    name:{
        type:String,
        required: true,

    },
    entry_date:{
        type:Date,
        required: true,

    },
    entry_time:{
        type:String,
        required: true,

    },
});

/*entry_dataSchema.virtual('exitData', {
    ref: 'exit_time', // Model name of the exit_dataModel
    localField: 'car_number', // Field in entry_dataModel
    foreignField: 'car_number', // Field in exit_dataModel
    justOne: true, // Set to true if you expect only one exit data per car number
  });*/
  

const entry_dataModel = db.model('entry_exit_time',entry_dataSchema);
module.exports = entry_dataModel;
