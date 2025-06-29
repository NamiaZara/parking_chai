const nodemailer = require('nodemailer');
const UserModel = require('../model/user.model');

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'parkingchai.nsu@gmail.com',
    pass: 'wqrk jciz czzd dodr',
  },
});

const sendPasswordResetEmail = async (email,tempPassword) => {
  await transporter.sendMail({
    from: 'parkingchai.nsu@gmail.com',
    //to: 'namiarandom5@gmail.com',
    to: email,
    subject: 'Password Reset',
    text: `Your temporary password is: ${tempPassword}. Please use this password to login and reset your password.`,
  });
};

module.exports = {
  sendPasswordResetEmail,
};
