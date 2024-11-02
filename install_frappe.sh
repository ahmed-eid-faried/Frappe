#!/bin/bash
# chmod +x install_frappe.sh
# ./install_frappe.sh

echo "Starting Frappe installation on macOS..."

# Install Xcode command line tools
echo "Installing Xcode command line tools..."
xcode-select --install

# Install Homebrew
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Install required packages using Homebrew
echo "Installing Python, Git, Redis, MariaDB, Node.js, and wkhtmltopdf..."
brew install python@3.12 git redis mariadb@10.6 node@18
brew install --cask wkhtmltopdf

# Configure MariaDB
echo "Configuring MariaDB..."
if [[ $(uname -m) == "arm64" ]]; then
    # For Apple Silicon
    CONFIG_PATH="/opt/homebrew/etc/my.cnf"
else
    # For Intel-based Macs
    CONFIG_PATH="/usr/local/etc/my.cnf"
fi

# Add MariaDB configuration if not already configured
if ! grep -q "character-set-server" "$CONFIG_PATH"; then
    echo "Adding configuration to MariaDB config file at $CONFIG_PATH"
    sudo tee -a "$CONFIG_PATH" >/dev/null <<EOL

[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
bind-address = 127.0.0.1

[mysql]
default-character-set = utf8mb4
EOL
else
    echo "MariaDB configuration already exists."
fi

# Restart MariaDB service
echo "Restarting MariaDB service..."
brew services restart mariadb@10.6

# Install Yarn globally
echo "Installing Yarn..."
npm install -g yarn

# Install Bench CLI
echo "Installing Frappe Bench..."
pip3 install --user frappe-bench || {
    echo "Failed to install frappe-bench, trying workaround with --break-system-packages"
    pip3 install --user frappe-bench --break-system-packages
}

# Check if installation was successful
if command -v bench &>/dev/null; then
    echo "Bench installed successfully."
else
    echo "Bench installation failed."
fi

# Verify installation
echo "Bench version:"
bench --version

# Add paths to .zshrc or .bash_profile
echo "Configuring paths for the installed tools..."
SHELL_PROFILE="$HOME/.zshrc" # Change to .bash_profile if using bash
{
    echo 'export PATH="/usr/local/opt/python@3.12/bin:$PATH"'
    echo 'export PATH="/usr/local/opt/mariadb@10.6/bin:$PATH"'
    echo 'export PATH="/usr/local/opt/redis/bin:$PATH"'
    echo 'export PATH="/usr/local/opt/node@18/bin:$PATH"'
} >>"$SHELL_PROFILE"

# Apply the changes
source "$SHELL_PROFILE"

# Create a new bench directory
echo "Creating a new Frappe bench environment..."
cd ~
bench init frappe-bench

echo "Frappe installation completed successfully! Paths have been configured."
