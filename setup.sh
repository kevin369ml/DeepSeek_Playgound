#!/bin/bash

# Function to install pip if not present
install_pip() {
    echo "Checking if pip is installed..."
    if ! command -v pip &> /dev/null; then
        echo "pip not found, installing pip..."
        # Install pip for Python 3
        curl -sS https://bootstrap.pypa.io/get-pip.py | python3
    else
        echo "pip is already installed"
    fi
}

# Function to install git if not present
install_git() {
    echo "Checking if git is installed..."
    if ! command -v git &> /dev/null; then
        echo "git not found, installing git..."
        if [ -x "$(command -v apt)" ]; then
            sudo apt update && sudo apt install git -y
        elif [ -x "$(command -v brew)" ]; then
            brew install git
        elif [ -x "$(command -v yum)" ]; then
            sudo yum install git -y
        else
            echo "Unsupported package manager. Please install git manually."
            exit 1
        fi
    else
        echo "git is already installed"
    fi
}

# Function to create a Python virtual environment
create_venv() {
    echo "Checking if virtualenv is installed..."
    if ! python3 -m venv --help &> /dev/null; then
        echo "virtualenv is not installed, installing..."
        python3 -m pip install --user virtualenv
    fi

    # Create a virtual environment
    echo "Creating virtual environment..."
    python3 -m venv myenv

    # Activate virtual environment
    echo "Activating virtual environment..."
    source myenv/bin/activate
}

# Function to install requirements from requirements.txt
install_requirements() {
    if [ -f "requirements.txt" ]; then
        echo "requirements.txt found, installing dependencies..."
        pip install -r requirements.txt
    else
        echo "No requirements.txt file found."
    fi
}

# Run the functions
install_pip
install_git
create_venv
install_requirements

echo "Setup complete!"
