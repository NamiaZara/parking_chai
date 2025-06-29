const db = require('../config/db');
const app_UserModel = require('../model/app_user.model');
const owner_UserModel = require('../model/user.model');
const mongoose = require('mongoose');
const { Schema } = mongoose;

const requestsendSchema = new Schema({
    userId: {
        type: Number ,
        // type: Schema.Types.ObjectId,
        // ref: app_UserModel.modelName
    },
    parkingOwnerId: {
        type: String,
        // type: Schema.Types.ObjectId,
        // ref:  owner_UserModel.modelName
    },
  
    status: {
        type: String,
        enum: ['pending', 'confirmed', 'rejected'],
        default: 'pending'
      }
},{timestamps:true});

const requestModel = db.model('request',requestsendSchema);
module.exports = requestModel;