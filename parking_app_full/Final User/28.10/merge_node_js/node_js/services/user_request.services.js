const Request = require('../model/user_request.model');

const sendRequest = async (userId, parkingOwnerId) => {
  const request = new Request({ userId, parkingOwnerId });
  await request.save();
  return request;
};

const getRequestsByOwner = async () => {
  try{
    const data= await Request.find({});
    return data;
   }catch(error){
    throw new Error('fail to fetch data');
    }
  //return Request.find({ parkingOwnerId });
};

const acceptRequest = async (requestId) => {
  return Request.findByIdAndUpdate(requestId, { status: 'accepted' });
};
const rejectRequest = async (requestId) => {
  return Request.findByIdAndUpdate(requestId, { status: 'rejected' });
};

const getUserRequests = async (userId) => {
  const requests = await Request.find({ userId });
  return requests;
};

module.exports = {
  sendRequest,
  getRequestsByOwner,
  acceptRequest,
  rejectRequest,
  getUserRequests,
};
