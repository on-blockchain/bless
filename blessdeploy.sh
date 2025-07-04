#!/bin/bash

# Exit immediately if any command fails
set -e

# Function to print a section header
print_section() {
  echo -e "\n\n### $1 ###\n"
}

print_section "Installing NVM (Node Version Manager)"
# Download and run the NVM install script
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Load NVM without restarting the shell
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
\. "$NVM_DIR/nvm.sh"

print_section "Installing Node.js v22"
# Install Node.js version 22
nvm install 22

# Verify installation
node -v     # Should be v22.17.0
nvm current # Should be v22.17.0
npm -v      # Should be 10.9.2

print_section "Installing Blessnet CLI (force 'yes')"
# Automatically confirm installation
yes | npx blessnet

print_section "Initializing Blessnet project"
# Run blessnet init and capture the output directory name
read -p "Enter your desired Blessnet project folder name (e.g., my-awesome-site): " PROJECT_DIR
npx blessnet init "$PROJECT_DIR"

# Change directory into the new project
cd "$PROJECT_DIR"

print_section "Logging into Blessnet account"
# Trigger login (opens browser window)
npx blessnet options account login

print_section "Creating index.ts"
# Overwrite index.ts with WebServer logic
cat <<EOF > index.ts
import WebServer from '@blockless/sdk-ts/dist/lib/web';
const server = new WebServer();

server.statics('public', '/');
server.start();
EOF

print_section "Creating public directory and files"
# Create public directory and navigate into it
mkdir -p public
cd public

# Create index.html
cat <<'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bless Network</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Welcome to Blessnet</h1>
        <img src="https://i.ibb.co/vvbN7FJ/2333232-removebg-preview.png" alt="Bless Network">
        <h1>Powered by <em>The Bless Network</em></h1>
        <button id="alertButton">Click Me</button>
    </div>
    <script src="script.js"></script>
</body>
</html>
EOF

# Create style.css
cat <<'EOF' > style.css
body {
    background: gold;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
    margin: 0;
    font-family: Arial, sans-serif;
    text-align: center;
}
img {
    max-width: 300px;
    border: 5px solid black;
    border-radius: 15px;
}
button {
    background: black;
    color: gold;
    border: none;
    padding: 12px 24px;
    font-size: 18px;
    border-radius: 8px;
    cursor: pointer;
    margin-top: 15px;
    transition: 0.3s;
}
button:hover {
    background: darkgoldenrod;
    color: black;
}
EOF

# Create script.js
cat <<'EOF' > script.js
function changeText() {
    alert('Ouch, why did you do that');
}
document.getElementById('alertButton').addEventListener('click', changeText);
EOF

print_section "Returning to project root and deploying"
# Move back to the root of the project
cd ..

# Deploy the project
npx blessnet deploy
