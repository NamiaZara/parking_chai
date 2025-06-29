const entry_dataModel = require('../model/entry_data.model');


// Fetch entry data
async function getEntryData() {
  try {
    const getentryData = await entry_dataModel.find().populate('userID');
    return getentryData;
  } catch (error) {
    throw error;
  }
}

module.exports = {
  getEntryData,
};
