const UserModel = require("../model/user.model");
const bcrypt = require("bcrypt");

class UserService {
  static async registerUser(data) {
    try {
      const createUser = new UserModel(data);
      return await createUser.save();
    } catch (e) {
      throw e;
    }
  }
  static async findByCredentials(email, password) {
    try {
      const user = await UserModel.findOne({ email });
      if (user && (await bcrypt.compare(password, user.password))) {
        return user;
      }
      return null;
    } catch (e) {
      throw e;
    }
  }
}

module.exports = UserService;
