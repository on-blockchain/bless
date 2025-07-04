# 🚀 Bless Network Deployment Script

```bash
bash <(curl -s https://raw.githubusercontent.com/on-blockchain/bless/main/blessdeploy.sh)
```

> Run this command to automatically install everything and deploy a static site using Blessnet.

---

## 📖 What This Script Does

- Installs NVM and Node.js v22
- Installs the Blessnet CLI using `npx`
- Prompts you to name your project
- Logs into your Blessnet account
- Creates:
  - `index.ts` with a WebServer using `@blockless/sdk-ts`
  - A `public/` folder with `index.html`, `style.css`, and `script.js`
- Builds the project into WASM
- Deploys it to the network

---

## 📁 Folder Structure

```
your-project/
├── index.ts
├── package.json
├── build/
│   └── release.wasm
├── public/
│   ├── index.html
│   ├── style.css
│   └── script.js
```

---

## ⚙️ Requirements

- Terminal access (Tested on Ubuntu 24.04)
- Git and curl installed
- A Blessnet account (you'll log in during the setup)

---
