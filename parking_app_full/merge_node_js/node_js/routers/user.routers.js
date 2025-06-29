const router = require("express").Router();
const UserController = require('../controller/user.controller');
const Entry_dataContrller = require('../controller/entry_data.controller');
const get_parking_owner = require('../controller/owner_data.controller');

const Exit_dataContrller = require('../controller/exit_data.controller');  //mridulla
const get_parking_history = require('../controller/parking_history.controller');  //mridulla

const ownerresetpassController = require('../controller/user.resetpass.controller');
const get_app_user = require('../controller/user_data.controller');

const locationController = require('../controller/user_location.controller');


router.post("/register",UserController.register);
router.post("/login", UserController.login);
router.post("/entry_data",Entry_dataContrller.entry_data);
router.get("/parking_owner_data",get_parking_owner.get_owner_data);
//router.get('/getExit_data',Exit_dataContrller.getExit_data);

router.post("/exit_data",Exit_dataContrller.exit_data);  //mridulla
router.get('/parking_history', get_parking_history.getCombinedData); //mridulla

router.post("/ownerresetpass", ownerresetpassController.resetPassword);
router.get("/app_user_data",get_app_user.get_appuser_data);

router.get('/user_location', locationController.searchLocations);

module.exports = router;
