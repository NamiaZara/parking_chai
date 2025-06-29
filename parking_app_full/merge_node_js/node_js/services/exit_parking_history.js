const exit_dataModel = require('../model/exit_data.model');

// Fetch exit data
async function getExitData() {
  try {
    const getexitData = await exit_dataModel.find().populate('userID');
    return getexitData;
  } catch (error) {
    throw error;
  }
}

module.exports = {
  getExitData,
};
