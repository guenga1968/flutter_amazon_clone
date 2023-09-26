//IMPORT FROM PACKAGES
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

// IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');

const config = {
    application: {
        cors: {
            server: [
                {
                    origin: "*", //servidor que deseas que consuma o (*) en caso que sea acceso libre
                    credentials: true
                }
            ]
        }
}
}

//INICIAR SERVIDOR
const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://gustavogallesio:Mongo1968@cluster0.8vn80ag.mongodb.net/?retryWrites=true&w=majority';

//MIDDELWARE
app.use(express.json());
app.use(cors(
    config.application.cors.server
  ));
app.use(authRouter);


// CONECTIONS
mongoose.connect(DB).then(()=>{
    console.log('Conexión exitosa con la base de datos');
}).catch(e =>{
    console.log(e);
});

// app.get('/', (req,res)=>{
//     res.json({nombre: 'Gustavo'});
// })

// app.get('/hola-mundo', (req,res)=>{
//     res.send('Hola Mundo');
// });



app.listen(PORT,'0.0.0.0', ()=>{
    console.log(`conectado al puerto ${PORT}`);
});
