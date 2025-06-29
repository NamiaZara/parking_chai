const UserServices = require('../services/user.services');

exports.register = async (req, res, next) => {
    try {//pass data
        //console.log("---req body---", req.body);
        const { name,address,location,contact_number,parking_space_number,per_hour_cost,email, password } = req.body;
        //const duplicate = await UserServices.getUserByEmail(email);
       // if (duplicate) {
          //  throw new Error(`UserName ${email,contact_number}, Already Registered`)
        //}
        const successRes = await UserServices.registerUser(name,address,location,contact_number,parking_space_number,per_hour_cost,email, password );
        res.json({ status: true, success: 'User registered successfully' });
    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}
exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
       // if (!email || !password) {
         //   throw new Error('Parameter are not correct');
        //}
        let user = await UserServices.checkUser(email);
        console.log("------user----",user);
        if (!user) {
            throw new Error('User does not exist');
        }
        const isPasswordCorrect = await user.comparePassword(password);
        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
        }
        // Creating Token
        let tokenData;
        tokenData = { _id: user._id,
             email: user.email, 
             name: user.name, 
             address: user.address,
             location:user.location,
             contact_number: user.contact_number,
             Space: user.parking_space_number,
             Cost_per_hr:user.per_hour_cost};
    
        const token = await UserServices.generateAccessToken(tokenData,"secret","1h")
        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}