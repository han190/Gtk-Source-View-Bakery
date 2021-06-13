#! /usr/bin/env bash

# BackupInstall ${FILENAME} ${FROM_DIR} ${TO_DIR}
BackupInstall(){
    if [ -f "$3/$1.bak" ] && [ -f "$3/$1" ]; then
        echo -e "${NC}'$1'${GREEN} already exists."
        echo -e "${NC}'$1.bak'${GREEN} already exists."
        echo -e "${YELLOW}=> Backup and overwrite $1."
        sudo cp $2/$1 $3
        return
    elif [ ! -f "$3/$1.bak" ] && [ -f "$3/$1" ]; then
        echo -e "${NC}'$1'${GREEN} already exists."
        echo -e "${NC}'$1.bak'${RED} doesn't exist."
        echo -e "${YELLOW}=> Backup and overwrite $1."
        sudo mv $3/$1 "$3/$1.bak"
        sudo cp $2/$1 $3
        return
    elif [ -f "$3/$1.bak" ] && [ ! -f "$3/$1" ]; then
        echo -e "${NC}'$1.bak'${GREEN} already exists."
        echo -e "${NC}'$1'${RED} doesn't exist."
        echo -e "${YELLOW}=> Create $1."
        sudo cp $2/$1 $3
    elif [ ! -f "$3/$1.bak" ] && [ ! -f "$3/$1" ]; then
        echo -e "${NC}'$1'${RED} doesn't exist."
        echo -e "${NC}'$1.bak'${RED} doesn't exist."
        echo -e "${YELLOW}=> Create $1."
        sudo cp $2/$1 $3
    fi
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Directories of .land and .xml files
GTK_DIR="/usr/share/gtksourceview-4"
GTK_LANG_DIR="${GTK_DIR}/language-specs"
GTK_STYLE_DIR="${GTK_DIR}/styles"

PROJ_DIR="$(pwd)"
LOCAL_LANG_DIR="${PROJ_DIR}/languages"
LOCAL_STYLE_DIR="${PROJ_DIR}/styles"

# backup and install all the files.
for file in ${LOCAL_LANG_DIR}/*.lang
do
    FILENAME=$(basename $file)
    BackupInstall ${FILENAME} ${LOCAL_LANG_DIR} ${GTK_LANG_DIR}
done

for file in ${LOCAL_STYLE_DIR}/*.xml
do
    FILENAME=$(basename $file)
    BackupInstall ${FILENAME} ${LOCAL_STYLE_DIR} ${GTK_STYLE_DIR}
done
echo -e "${CYAN}=> The GtkSourceView is successfully baked!"
