import express from "express";
import dotenv from "dotenv";


dotenv.config();

const PORT  =   3000;

const app   =   express();

    //! Librerias de Express
//* Middlewares

app.use(cors());
app.use(express.json());            //* Permite leer el body de los POST json
app.use(express.urlencoded())       //* Permite leer el body de los POST en formularios
app.get("/", (req, res) => {
    res.send("<h1>Vida Loca</h1>")
});


app.listen(PORT, () => {
    console.log("Application running");
});

