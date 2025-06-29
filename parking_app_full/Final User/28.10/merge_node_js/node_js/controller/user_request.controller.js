const requestService = require('../services/user_request.services');

// const sendRequest = async (req, res) => {
//   const { userId, parkingOwnerId } = req.body;
//   try {
//     const request = await requestService.sendRequest(userId, parkingOwnerId);
//     res.status(201).json(request);
//   } catch (error) {
//     console.error(error);
//     res.status(500).send('Internal Server Error');
//   }
// };

// const getUserRequests = async (req, res) => {
//   const { userId } = req.params;
//   try {
//     const requests = await requestService.getUserRequests(userId);
//     res.json(requests);
//   } catch (error) {
//     console.error(error);
//     res.status(500).send('Internal Server Error');
//   }
// };

// module.exports = {
//   sendRequest,
//   getUserRequests
// };


const sendRequest = async (req, res) => {
  const { userId, parkingOwnerId } = req.body;
  try {
    const request = await requestService.sendRequest(userId, parkingOwnerId);
    res.status(201).json(request);
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
};

const getRequestsByOwner = async (req, res) => {
  //const { parkingOwnerId } = req.params;
  try {
    const requests = await requestService.getRequestsByOwner();
    res.status(200).json(requests);
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
};

const acceptRequest = async (req, res) => {
  const { requestId } = req.params;
  try {
    await requestService.acceptRequest(requestId);
    res.send('Request accepted successfully');
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
};
const rejectRequest = async (req, res) => {
  const { requestId } = req.params;
  try {
    await requestService.rejectRequest(requestId);
    res.send('Request rejecteded successfully');
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
};
const getUserRequests = async (req, res) => {
  const { userId } = req.params;
  try {
    const requests = await requestService.getUserRequests(userId);
    res.json(requests);
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
};

module.exports = {
  sendRequest,
  getRequestsByOwner,
  acceptRequest,
  rejectRequest,
  getUserRequests,
};
