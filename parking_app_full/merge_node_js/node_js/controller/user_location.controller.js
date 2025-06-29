const locationService = require('../services/user_location.services');

async function searchLocations(req, res) {
  const location = req.query.location;
  try {
    const users = await locationService.searchLocations(location);
    res.json(users);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
}

module.exports = {
  searchLocations,
};
