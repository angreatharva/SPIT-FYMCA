const DrModel = require("../model/dr.model");
const bcrypt = require("bcrypt");

class DrService {
  static async registerDr(data) {
    try {
      const createDr = new DrModel(data);
      return await createDr.save();
    } catch (e) {
      throw e;
    }
  }
  static async findByCredentials(email, password) {
    try {
      const doctor = await DrModel.findOne({ email });
      if (doctor && (await bcrypt.compare(password, doctor.password))) {
        return doctor;
      }
      return null;
    } catch (e) {
      throw e;
    }
  }
  static async getAllDoctors() {
    try {
      const doctors = await DrModel.find({});
      return doctors;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = DrService;
