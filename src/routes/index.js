
import { Router } from "express";
import apiRouter from "./api/api.route.js";
import viewRouter from "./view.route.js";

const router    = Router();
router.use("/", viewRouter);
router.use("/api", apiRouter);

export default router;