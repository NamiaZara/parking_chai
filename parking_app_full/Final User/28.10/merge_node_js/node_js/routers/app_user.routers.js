const router = require("express").Router();
const UserController2 = require('../controller/app_user.controller');
const userresetpassController = require('../controller/app_user.resetpass.controller');
const requestsend = require('../controller/user_request.controller');


router.post("/user_register",UserController2.register);
router.post("/user_login", UserController2.login);

router.post("/userresetpass", userresetpassController.resetPassword);

router.post('/user/request', requestsend.sendRequest);
router.get('/owner/requests', requestsend.getRequestsByOwner);
router.post('/owner/requests/accept/:requestId', requestsend.acceptRequest);
router.post('/owner/requests/reject/:requestId', requestsend.rejectRequest);
router.get('/user/:userId', requestsend.getUserRequests);

module.exports = router;