//db.js
const oracledb = require("oracledb");

// db setting
const dbConfig = {
  user: "scott",
  password: "tiger",
  connectString: "localhost:1521/xe",
};

async function getConnection() {
  try {
    const connection = await oracledb.getConnection(dbConfig);
    console.log("db 접속 성공");
    return connection;
  } catch (err) {
    throw err;
  }
  // .then(function () {
  //   console.log("ok");
  // })
  // .catch(function () {
  //   console.log("ng");
  // });
}
getConnection();

module.exports = { getConnection }; // export 다른 js 사용.
