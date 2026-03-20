#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
DJANGO_URL=$1
DJANGO_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "==============="
echo -e "=== INSTALL ==="
echo -e "==============="
echo -e "\n"

echo -e "[INSTALL][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[INSTALL][ARGS] DJANGO URL: ${DJANGO_URL}"
echo -e "[INSTALL][ARGS] DJANGO VERSION: ${DJANGO_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${INSTALL_PATH} || -z ${DJANGO_URL} || -z ${DJANGO_VERSION} ]]; then
    echo -e "\n"
    echo -e "[INSTALL][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"
    exit 1
fi

# We install Django.
echo -e "\n"
echo -e "[INSTALL] Installing django-${DJANGO_VERSION}..."
echo -e "\n"

# We try to install Django and check if the installation is successful
# pip install ${DJANGO_URL} --target ${INSTALL_PATH} --upgrade --no-dependencies
echo -e "python3 -m pip install Django==3.2.25 --target ${INSTALL_PATH} --upgrade"
python3 -m pip install Django==3.2.25 --target ${INSTALL_PATH} --upgrade

if [ $? -eq 0 ]; then
    echo -e "[INSTALL] Django-${DJANGO_VERSION} installed successfully!"
else
    echo -e "[INSTALL] Installation failed!"
    exit 1
fi

# Verify that the Django files are in the install path
if [ -d "${INSTALL_PATH}/django" ]; then
    echo -e "[INSTALL] Django files are present in the install path."
else
    echo -e "[INSTALL] Django installation failed. Files not found in ${INSTALL_PATH}/django."
    exit 1
fi

echo -e "\n"
echo -e "[INSTALL] Finished installing django-${DJANGO_VERSION}!"
echo -e "\n"

