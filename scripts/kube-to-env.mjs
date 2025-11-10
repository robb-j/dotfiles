#!/usr/bin/env node

import process from "node:process";
import fs from "node:fs";
import cp from "node:child_process";
import assert from "node:assert/strict";
import { parseArgs } from "node:util";

const usage = `
usage:
	./kube-to-env.mjs get <secret-name> [--quotes] [--sort]
	./kube-to-env.mjs diff <secret-name> <input-file>
`;

// Parse CLI arguments
const args = parseArgs({
  args: process.argv.slice(2),
  options: {
    help: { type: 'boolean', default: false, short: 'h' },
    quotes: { type: 'boolean', default: false },
    sort: { type: 'boolean', default: false },
  },
  allowPositionals: true
})

const [command, secretName, inputFile] = args.positionals

if (!secretName || args.values.help) {
  console.error(usage);
  process.exit(1);
}

// Get the secret
const result = cp.execSync(`kubectl get secret ${secretName} -o json`);
const secret = JSON.parse(result.toString());

// 
// get command
// 
if (command === "get") {
  // Format as a .env file
  const env = [];
  const quoteChar = args.values.quotes ? '"' : "";
  for (const [key, value] of Object.entries(secret?.data ?? {})) {
    env.push(`${key}=${quoteChar}${atob(value)}${quoteChar}`);
  }

  // Sort if requested
  if (args.values.sort) env.sort();

  // Output the .env file to stdout
  console.log(env.join("\n"));
}

// 
// diff command
// 
if (command === "diff") {
  // Read in the dotenv
  const data = fs.readFileSync(inputFile, "utf8");
  const localEnv = {};

  // parse out key-value pairs
  for (const match of data.matchAll(/^(?<key>.*?)="?(?<value>.*)"?$/gm)) {
    localEnv[match.groups.key] = match.groups.value;
  }

  // decode the base-64 remote secret
  const remoteEnv = {};
  for (const [key, value] of Object.entries(secret?.data ?? {})) {
    remoteEnv[key] = atob(value);
  }

  // assert the local and remote secrets using node:assert
  try {
    assert.deepEqual(localEnv, remoteEnv);
    console.log("secrets/%s and %s are in sync", secretName, inputFile);
  } catch (error) {
    console.error(error.message);
    process.exit(1);
  }
}
