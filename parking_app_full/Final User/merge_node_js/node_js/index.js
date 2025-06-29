const app = require("./app");
const db = require('./config/db')
const UserModel = require('./model/user.model')
const entry_dataModel =require('./model/entry_data.model')
const Exit_dataModel =require('./model/exit_data.model')
const UserModel2 = require('./model/app_user.model')

const port = 3000;

app.get('/',(req,res)=>{
    res.send("why")

});
app.listen(port,()=>{
    console.log(`Server Listening on Port http://localhost:${port}`);
})