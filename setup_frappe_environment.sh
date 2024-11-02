#!/bin/bash
# chmod +x setup_frappe_environment.sh
# ./setup_frappe_environment.sh

# Function to check if a command exists
command_exists() {
    command -v "$1" &>/dev/null
}

# Python
echo "Checking for Python..."
if command_exists python3; then
    echo "Python is already installed."
else
    echo "Python is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install python3
    else
        sudo apt update && sudo apt install -y python3
    fi
fi
echo "Learn Python: https://www.codecademy.com/learn/learn-python-3"
echo "Official Python Tutorial: https://docs.python.org/3/tutorial/"

# MariaDB or PostgreSQL
echo "Checking for MariaDB/PostgreSQL..."
if command_exists mysql; then
    echo "MariaDB is already installed."
elif command_exists psql; then
    echo "PostgreSQL is already installed."
else
    echo "MariaDB/PostgreSQL is not installed. Installing MariaDB..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install mariadb
    else
        sudo apt update && sudo apt install -y mariadb-server
    fi
fi
echo "Learn SQL: https://www.codecademy.com/learn/learn-sql"
echo "Getting started with MariaDB: https://mariadb.com/kb/en/getting-started-with-the-mariadb-server/"

# Node.js for JavaScript (optional, but useful for JavaScript development)
echo "Checking for Node.js..."
if command_exists node; then
    echo "Node.js is already installed."
else
    echo "Node.js is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install node
    else
        sudo apt update && sudo apt install -y nodejs
    fi
fi
echo "Learn JavaScript: https://javascript.info/"
echo "Learn jQuery: https://www.codecademy.com/learn/learn-jquery"

# Git
echo "Checking for Git..."
if command_exists git; then
    echo "Git is already installed."
else
    echo "Git is not installed. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install git
    else
        sudo apt update && sudo apt install -y git
    fi
fi
echo "Learn Git: https://www.codecademy.com/learn/learn-git"
echo "How to contribute to Open Source: https://opensource.guide/how-to-contribute/"

# Display learning resources for HTML, CSS, Bootstrap, and Jinja
echo "Learning Resources:"
echo "HTML/CSS: https://www.codecademy.com/learn/learn-html"
echo "Bootstrap: https://getbootstrap.com/docs/5.0/getting-started/introduction/"
echo "Jinja Templating: https://jinja.palletsprojects.com/"

echo "Setup complete! You are now ready to build an app with the Frappe Framework."
