const express = require("express");
const bodyParser = require("body-parser")
const userRoute = require("./routers/user.routers");
const app_userRoute = require("./routers/app_user.routers");




const app = express();

app.use(bodyParser.json())
app.use("/",userRoute);
app.use("/",app_userRoute);


module.exports = app;