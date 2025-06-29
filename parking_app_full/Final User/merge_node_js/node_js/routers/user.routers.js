const router = require("express").Router();
const UserController = require('../controller/user.controller');
const Entry_dataContrller = require('../controller/entry_data.controller');
const get_parking_owner = require('../controller/owner_data.controller');
const Exit_dataContrller = require('../controller/exit_data.controller');
const get_parking_history = require('../controller/parking_history.controller');

const ownerresetpassController = require('../controller/user.resetpass.controller');


router.post("/register",UserController.register);
router.post("/login", UserController.login);
router.post("/entry_data",Entry_dataContrller.entry_data);
router.post("/exit_data",Exit_dataContrller.exit_data);
router.get("/parking_owner_data",get_parking_owner.get_owner_data);
//router.get('/getExit_data',Exit_dataContrller.getExit_data);
router.get('/parking_history', get_parking_history.getCombinedData);

router.post("/ownerresetpass", ownerresetpassController.resetPassword);

module.exports = router;
