const UserModel = require('../model/app_user.model');
const user_resetpass_services =require('../services/app_user.resetpass.services');

const resetPassword = async (req, res) => {
  const { user_email } = req.body;
  try {
    const user = await UserModel.findOne({ user_email: user_email });

    if (user) {
      const tempPassword = Math.random().toString(36).slice(-8);
      user.user_password = tempPassword;
      await user.save();
      await user_resetpass_services.sendPasswordResetEmail(user_email, tempPassword);
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
