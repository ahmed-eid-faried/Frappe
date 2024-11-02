# #!/bin/bash
# # chmod +x create_erpnext.sh
# # ./create_erpnext.sh

# # Variables
# ERP_NEXT_VERSION="v15.0.0"
# PROJECT_NAME="erpnext_v15_project"
# FRAPPE_BRANCH="version-15" # Branch for ERPNext v15
# MYSQL_ROOT_PASSWORD="root"
# ADMIN_PASSWORD="admin"
# SITE_NAME="erpnext.local"
# APP="erpnext"

# # Install dependencies using Homebrew
# echo "Installing dependencies..."
# brew update
# brew install python3 redis mariadb@10.6 node npm wkhtmltopdf libffi libssl

# # Set up MariaDB
# echo "Configuring MariaDB..."
# brew services start mariadb@10.6
# mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = '${MYSQL_ROOT_PASSWORD}';"
# mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# # Create a Python virtual environment
# echo "Creating virtual environment..."
# python3 -m venv erpnext-env
# source erpnext-env/bin/activate

# # Install Frappe Bench
# echo "Installing Frappe Bench..."
# pip install frappe-bench

# # Initialize Frappe Bench
# echo "Initializing Frappe Bench..."
# bench init --frappe-branch ${FRAPPE_BRANCH} --python python3 ${PROJECT_NAME}

# # Change to project directory
# cd ${PROJECT_NAME}

# # Create new site
# echo "Creating new site..."
# bench new-site ${SITE_NAME} --admin-password ${ADMIN_PASSWORD} --mariadb-root-password ${MYSQL_ROOT_PASSWORD}

# # Get ERPNext application
# echo "Getting ERPNext version ${ERP_NEXT_VERSION}..."
# bench get-app --branch ${FRAPPE_BRANCH} ${APP}

# # Install ERPNext on the site
# echo "Installing ERPNext on the site..."
# bench --site ${SITE_NAME} install-app ${APP}

# # Start ERPNext
# echo "Starting ERPNext..."
# bench start
