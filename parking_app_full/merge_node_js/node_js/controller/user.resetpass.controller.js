const UserModel = require('../model/user.model');
const user_resetpass_services =require('../services/user.resetpass.services');

const resetPassword = async (req, res) => {
  const { email } = req.body;
  try {
    const user = await UserModel.findOne({ email: email });

    if (user) {
      const tempPassword = Math.random().toString(36).slice(-8);
      user.password = tempPassword;
      await user.save();
      await user_resetpass_services.sendPasswordResetEmail(email, tempPassword);
      res.status(200).send('Password reset email sent successfully');
    } else {
      res.status(404).send('Email not found');
    }
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal Server Error');
  }
};

module.exports = {
  resetPassword,
};
