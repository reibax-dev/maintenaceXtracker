import { Router } from "express";

const router    = Router();

router.get("/", (req, res) => {
    res.json ({ message: "Vida Loca From API"})
})

export default router;