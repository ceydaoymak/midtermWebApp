const express = require("express");
const { Client } = require("pg");
const { DefaultAzureCredential } = require("@azure/identity");
const { SecretClient } = require("@azure/keyvault-secrets");

const app = express();
const port = process.env.PORT || 8080;

const keyVaultUrl = "https://group15Vault.vault.azure.net";
const credential = new DefaultAzureCredential();
const secretClient = new SecretClient(keyVaultUrl, credential);

app.get("/hello", async (req, res) => {
  try {

    const dbHost = (await secretClient.getSecret("DBHOST")).value;
    const dbUser = (await secretClient.getSecret("DBUSER")).value;
    const dbPass = (await secretClient.getSecret("DBPASS")).value;
    const dbName = (await secretClient.getSecret("DBNAME")).value;

    const client = new Client({
      host: dbHost,
      user: dbUser,
      password: dbPass,
      database: dbName,
      ssl: { rejectUnauthorized: false }, 
    });

    await client.connect();
    const result = await client.query("SELECT NOW()");
    await client.end();

    res.send(`Hello from AZURE GROUP 15`);

  } catch (error) {
    console.error("Connection Error:", error);
    res.status(500).send("DB connection failed.");
  }
});

app.listen(port, () => {
  console.log(` Server running at http://localhost:${port}`);
});
