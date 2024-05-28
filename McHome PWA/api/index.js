require('dotenv').config();
const express = require('express');
const QRCode = require('qrcode');
const { MongoClient } = require('mongodb');

const app = express();
const port = 3001;

const uri = process.env.MONGODB_URI;

const client = new MongoClient(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

client.connect().then(() => {
    console.log('We are connected to MongoDB Atlas');
    const database = client.db("BurgersAndPins");
    const collection = database.collection("BurgirsAndPins");

    app.get('/qr-code/:id', async (req, res) => {
        const id = req.params.id; // keep id as a string
        const document = await collection.findOne({ _id: id });

        if (!document) {
            return res.status(404).send("No document found with the provided ID.");
        }

        QRCode.toDataURL(id, function (err, url) {
            if (err) return res.status(500).send("An error occurred while generating the QR code.");
            res.send(`<img src="${url}"/>`);
        });
    });

    app.get('/all-qr-codes', async (req, res) => {
        const documents = await collection.find().toArray();
        let qrUrls = await Promise.all(documents.map(document => {
            let id = document._id;
            return new Promise((resolve, reject) => {
                QRCode.toDataURL(id, function (err, url) {
                    if (err) reject("An error occurred while generating the QR code.");
                    resolve(`<img src="${url}"/>`);
                });
            });
        }));

        res.send(qrUrls.join(''));
    });

    app.use((req, res, next) => {
        res.header("Access-Control-Allow-Origin", "*");
        next();
    })

    app.get('/', (req, res) => {
        res.statusCode = 200;
        res.setHeader('Content-Type', 'text/plain');
        res.end('Hello World');
    });

    app.get('/bobob/', (req, res) => {
        res.statusCode = 200;
        res.setHeader('Content-Type', 'application/json');
        collection.find().toArray().then((documents) => {
            res.end(JSON.stringify(documents));
        });
    });

    app.listen(port, () => {
        console.log(`Example app listening on port ${port}`);
    });
}).catch((err) => {
    console.error(err);
});































// require('dotenv').config();
// const express = require('express');
// const QRCode = require('qrcode');
// const { MongoClient, ObjectId } = require('mongodb');

// const app = express();
// const port = 3000;

// const uri = process.env.MONGODB_URI;

// const client = new MongoClient(uri, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
// });

// client.connect().then(() => {
//     console.log('We are connected to MongoDB Atlas');
//     const database = client.db("BurgersAndPins");
//     const collection = database.collection("BurgirsAndPins");

//     app.get('/qr-code/:id', async (req, res) => {
//         const id = req.params.id;
//         const document = await collection.findOne({ _id: ObjectId(id) });

//         if (!document) {
//             return res.status(404).send("No document found with the provided ID.");
//         }

//         QRCode.toDataURL(id, function (err, url) {
//             if (err) return res.status(500).send("An error occurred while generating the QR code.");
//             res.send(`<img src="${url}"/>`);
//         });
//     });

//     app.use((req, res, next) => {
//         res.header("Access-Control-Allow-Origin", "*");
//         next();
//     });

//     app.get('/', (req, res) => {
//         res.statusCode = 200;
//         res.setHeader('Content-Type', 'text/plain');
//         res.end('Hello World');
//     });

//     app.get('/bobob/', (req, res) => {
//         res.statusCode = 200;
//         res.setHeader('Content-Type', 'application/json');
//         collection.find().toArray().then((documents) => {
//             res.end(JSON.stringify(documents));
//         });
//     });

//     app.listen(port, () => {
//         console.log(`Example app listening on port ${port}`);
//     });
// }).catch((err) => {
//     console.error(err);
// });







































// require('dotenv').config()
// const express = require('express');
// const mongoose = require('mongoose');
// const QRCode = require('qrcode');
// const app = express();
// const port = 3000


// mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true });

// const db = mongoose.connection;
// db.on('error', console.error.bind(console, 'connection error:'));
// db.once('open', function() {
//   console.log('We are connected to MongoDB Atlas');
// });


// const { MongoClient, ServerApiVersion } = require('mongodb');
// const uri = "mongodb+srv://SecondGear16:Verticle0616@clusterfock.exoicco.mongodb.net/?retryWrites=true&w=majority";
// // Create a MongoClient with a MongoClientOptions object to set the Stable API version


// const client = new MongoClient(uri, {
//   serverApi: {
//     version: ServerApiVersion.v1,
//     strict: true,
//     deprecationErrors: true,
//   }

  
// });

// // This should be the id fetched from your MongoDB collection.
// let id = '6401'; 

// QRCode.toDataURL(id, function (err, url) {
//   if (err) return console.log("error occurred: ", err);
//   console.log(url);
// });

// client.connect().then(()=>{
//     const pokemonDatabase=client.db("BurgersAndPins")
//     const pokemoncollection = pokemonDatabase.collection("BurgirsAndPins")
    
//     app.get('/qr-code', async (req, res) => {
//       // Fetch the ID from your MongoDB collection here.
//       // For the purposes of this example, we'll just use a hardcoded string.
//       let id = '6401';
      
//       QRCode.toDataURL(id, function (err, url) {
//         if (err) return res.status(500).send("An error occurred while generating the QR code.");
//         res.send(`<img src="${url}"/>`);
//       });
//     });
    
//     app.use((req,res,next)=>{
//       res.header("Access-Control-Allow-Origin", "*");
//       next();
//     })

//     app.get('/', (req, res) => {
//       res.statusCode = 200;
//       res.setHeader('Content-Type', 'text/plain');
//       res.end('Fuck off');
//     })
//     app.get('/bobob/', (req, res) => {
//       res.statusCode = 200;
//       res.setHeader('Content-Type', 'application/json');
//       pokemoncollection.find().toArray().then((document)=>{
       
//         res.end(JSON.stringify(document))
//       })
//     })

//     app.listen(port, () => {
//       console.log(`Example app listening on port ${port}`)
//     })

//   })
