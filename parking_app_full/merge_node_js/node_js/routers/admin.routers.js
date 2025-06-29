const router = require("express").Router();
const UserController3 = require('../controller/admin.controller');

router.post("/admin_register",UserController3.register);
router.post("/admin_login", UserController3.login);

module.exports = router;