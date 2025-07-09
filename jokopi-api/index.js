import 'dotenv/config'; // enviroment
import fs from 'fs';
import https from 'https';
import cors from 'cors';
import express from 'express'; // express js
import mongoose from 'mongoose';
import morgan from 'morgan';

// routes
import routers from './src/routers/index.js';

const app = express();

const {
  APP_PORT = 5000,
  SSL_KEY_PATH = './certs/api.key',
  SSL_CERT_PATH = './certs/api.crt',
} = process.env;

// Middleware
app.use(cors());

app.use(
  morgan(":method :url :status :res[content-length] - :response-time ms")
);

app.use(express.json()); // body json
app.use(express.urlencoded({ extended: false })); // form-urlencoded

app.use(routers);
// using public folders
app.use(express.static("public"));

// start server with mongoose (mongodb module)
// mongoose
//   .connect(
//     `mongodb+srv://${process.env.MONGODB_USER}:${process.env.MONGODB_PASS}@${process.env.MONGODB_HOST}/${process.env.MONGODB_NAME}?retryWrites=true&w=majority`
//   )
//   .then(() => {
//     console.log("Mongo DB Connected");
//     app.listen(APP_PORT, () => {
//       console.log(`Server is running at port ${APP_PORT}`);
//     });
//   })
//   .catch((err) => console.log(err));

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => {
  console.log("Mongo DB Connected");
  // app.listen(APP_PORT, () => {
  //   console.log(`Server is running at port ${APP_PORT}`);
  // });
})
.catch((err) => console.log("MongoDB connection error", err));

// Read SSL key and cert (ECDSA)
const httpsOptions = {
  key: fs.readFileSync(SSL_KEY_PATH),
  cert: fs.readFileSync(SSL_CERT_PATH),
};

// Start HTTPS server
https
  .createServer(httpsOptions, app)
  .listen(APP_PORT, () => {
    console.log(`HTTPS Server running on port ${APP_PORT}`);
  });

export default app;
