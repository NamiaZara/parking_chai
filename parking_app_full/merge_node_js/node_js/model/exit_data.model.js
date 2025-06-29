const mongoose = require('mongoose');
const Entry_dataModel = require('../model/entry_data.model'); 
const UserModel = require('../model/user.model');// Assuming the correct path
const db = require('../config/db');

const { Schema } = mongoose;

const exit_dataSchema = new Schema({
    userID:{
        type: Schema.Types.ObjectID,
        ref: UserModel.modelName,
    },

    car_number: {
        type: String, // Ensure it's the same type as in entry_dataSchema
        required: true,
    },
    
    exit_date: {
        type: Date,
        required: true,
    },
    exit_time: {
        type: String,
        required: true,
    }
});

const exit_dataModel = db.model('exit_time', exit_dataSchema);
module.exports = exit_dataModel;
