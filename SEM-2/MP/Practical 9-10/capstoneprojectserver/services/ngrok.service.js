const ngrok = require('ngrok');
const config = require('../config/server.config');

const setupNgrok = async () => {
  try {
    if (!config.ngrokEnabled) {
      console.log('Ngrok disabled by configuration');
      return;
    }
    
    const url = await ngrok.connect({
      proto: "http",
      addr: config.port,
      authtoken: config.ngrokToken,
    });
    
    console.log(`\n🎉 Public URL (share this!): ${url}\n`);
    return url;
  } catch (err) {
    console.error("Failed to start ngrok:", err);
    return null;
  }
};

module.exports = setupNgrok; 