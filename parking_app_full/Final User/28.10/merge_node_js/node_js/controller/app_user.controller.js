const UserServices = require('../services/app_user.services');

exports.register = async (req, res, next) => {
    try {//pass data
        //console.log("---req body---", req.body);
        const { first_name,last_name,user_contact_number,user_email,user_password } = req.body;
        //const duplicate = await UserServices.getUserByEmail(email);
       // if (duplicate) {
          //  throw new Error(`UserName ${email,contact_number}, Already Registered`)
        //}
        const successRes = await UserServices.registerUser(first_name,last_name,user_contact_number,user_email,user_password );
        res.json({ status: true, success: 'User registered successfully' });
    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}
exports.login = async (req, res, next) => {
    try {
        const { user_email, user_password } = req.body;
       // if (!email || !password) {
         //   throw new Error('Parameter are not correct');
        //}
        let user = await UserServices.checkUser(user_email);
        console.log("------user----",user);
        if (!user) {
            throw new Error('User does not exist');
        }
        const isPasswordCorrect = await user.comparePassword(user_password);
        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }
        // Creating Token
        let tokenData;
        tokenData = { user_id: user._id, user_email: user.user_email,name1:user.first_name,name2:user.last_name,Phn:user.user_contact_number };
    
        const token = await UserServices.generateAccessToken(tokenData,"secret","1h")
        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

// exports.getappuserprofile = async(req,res,next)=>{
//     try {
//         const { user_email} = req.body;
//         let successRes = await UserServices.getprofile(user_email);
//         res.json({ status: true, success: successRes });
//     } catch (err) {
//         //console.log("---> err -->", err);
//         next(err);
//     }
// }