# Venus UI

A lightweight React + Vite starter using React Router and a small landing page UI.

[![License: MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat-square)]()

## Table of contents

* [Introduction](#introduction)
* [Highlights in this branch](#highlights-in-this-branch)
* [Installation](#installation)
* [Quick start (development)](#quick-start-development)
* [Building and deployment](#building-and-deployment)
* [Project layout](#project-layout)
* [Getting help and contributing](#getting-help-and-contributing)
* [License](#license)

## Introduction

Venus UI is a small React UI scaffold intended as the front-end for the Venus project. It uses Vite + TypeScript and React Router for client-side routing. This README follows the mhucka/readmine suggested structure.

## Highlights in this branch

Unreleased (branch: feature/initial-landing-page)

- Added an initial landing page at / (app/landing/*)
- Added basic React Router setup and routes (app/routes.ts, app/routes/home.tsx)
- Added images and styles for the landing page (app/landing/, app/app.css)
- Added Dockerfile and deploy.dev.sh for simple deployment testing
- Added package.json and lockfile to track dependencies
- Added react-router skill docs under .agents/skills/react-router (documentation files)

## Installation

Prerequisites: Node 18+, npm 9+, or an equivalent node toolchain.

Install dependencies:

```sh
npm install
```

## Quick start (development)

Start the dev server (hot reload enabled):

```sh
npm run dev
```

Open: http://localhost:5173

## Building and deployment

Create a production build:

```sh
npm run build
```

Docker (local test):

```shndocker build -t venus-ui:local .
docker run -p 3000:3000 venus-ui:local
```

There is a simple deploy script for development hosts: deploy.dev.sh (make executable on Unix-like systems).

## Project layout

Key paths added or modified in this branch:

- app/landing/ — landing page components and images
- app/routes.ts, app/routes/home.tsx — route definitions and home route
- app/root.tsx — application entry wiring
- app/app.css — lightweight styles for landing page
- Dockerfile, deploy.dev.sh — containerization and dev deploy helper
- react-router.config.ts — router configuration helper (TypeScript)
- .agents/skills/react-router/ — documentation for the react-router skill (not part of runtime)

## Getting help and contributing

Open an issue or a PR describing the problem or feature. For this branch, review focuses on the landing page, routing, and deployment artifacts.

Contributing notes:
- Keep changes small and focused per PR
- Run the dev server and verify the landing page renders at /

## License

MIT License

---

Generated using the mhucka/readmine README structure adapted for this project.
