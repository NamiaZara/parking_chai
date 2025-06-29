const entryDataService = require('../services/entry_parking_history.services');
const exitDataService = require('../services/exit_parking_history');

async function getCombinedData(req, res) {
  try {
    // Use entryDataService and exitDataService functions to fetch data
    const entryData = await entryDataService.getEntryData();
    const exitData = await exitDataService.getExitData();
    
    // Combine or structure the data as needed
    const combinedData = {
      entryData,
      exitData,
    };
    
    res.json(combinedData);
  } catch (error) {
    res.status(500).json({ error: 'Internal server error' });
  }
}

module.exports = {
  getCombinedData,
};
