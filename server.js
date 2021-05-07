const express = require("express");

const helmet = require("helmet");
const cors = require("cors");
const LoggerInstance = require("./logger");
const database = require("./database");

const app = express();

const Sentry = require("@sentry/node");
const Tracing = require("@sentry/tracing");

Sentry.init({
  dsn:
    "https://4a80c18c78704e82a98650a902ffdf98@o623789.ingest.sentry.io/5753183",
  integrations: [
    new Sentry.Integrations.Http({ tracing: true }),
    new Tracing.Integrations.Express({ app }),
  ],
  tracesSampleRate: 1.0,
});
app.use(Sentry.Handlers.requestHandler());
app.use(Sentry.Handlers.tracingHandler());

app.use(express.json());

const port = process.env.PORT || 8000;

const authRouter = require("./src/auth/router");

app.use("/auth", authRouter);

const notesRouter = require("./src/notes/router");

app.use("/notes", notesRouter);

app.get("/debug-sentry", function mainHandler(req, res) {
  throw new Error("My first Sentry error!");
});

app.get("/", (req, res) => {
  res.status(200).json({
    message: "Server Started",
  });
});

app.use("*", (req, res) => {
  res.status(404).json({
    message: "Route Not Found",
  });
});

app.use(Sentry.Handlers.errorHandler());

app.use(helmet());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

app.listen(port, (err) => {
  if (err) {
    LoggerInstance.error(err);
  } else {
    database()
      .then((val) => {
        LoggerInstance.info("Server Started");
      })
      .catch((e) => {
        LoggerInstance.error(e);
      });
  }
});
