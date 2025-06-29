const UserModel = require('../model/user.model');

async function searchLocations(location) {
  try {
    const users = await UserModel.find({ location: { $regex: location, $options: 'i' } });
    return users;
  } catch (error) {
    throw error;
  }
}

module.exports = {
  searchLocations,
};
