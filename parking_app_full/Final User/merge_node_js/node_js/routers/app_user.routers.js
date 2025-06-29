const router = require("express").Router();
const UserController2 = require('../controller/app_user.controller');
const userresetpassController = require('../controller/app_user.resetpass.controller');

router.post("/user_register",UserController2.register);
router.post("/user_login", UserController2.login);
// router.get("/getappuserprofile",UserController.getappuserprofile);
router.post("/userresetpass", userresetpassController.resetPassword);
module.exports = router;