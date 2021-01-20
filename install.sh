#! /usr/bin/env bash

BackupInstall(){
    if [ -f "$2/$1.bak" ] && [ -f "$2/$1" ]; then
        echo "Both '$1' and '$1.bak' exist. Overwrite '$1'."
        sudo cp $1 $2
        return
    elif [ ! -f "$2/$1.bak" ] && [ -f "$2/$1" ]; then
        echo "'$1' exists, but '$1.bak' does not."
        echo "Create '$1.bak' and overwrite '$1'."
        sudo mv $2/$1 "$2/$1.bak"
        sudo cp $1 $2
        return
    elif [ -f "$2/$1.bak" ] && [ ! -f "$2/$1" ]; then
        echo "'$1.bak' exists, but '$1' does not. Create '$1'."
        sudo cp $1 $2
    elif [ ! -f "$2/$1.bak" ] && [ ! -f "$2/$1" ]; then
        echo "Both '$1' and '$1.bak' don't exist. Create '$1'."
        sudo cp $1 $2
    fi
}

# Directories of .land and .xml files
GTK_DIR="/usr/share/gtksourceview-4"
LANG_DIR="${GTK_DIR}/language-specs"
STYLE_DIR="${GTK_DIR}/styles"

# Languages
FORTRAN="fortran.lang"
GNUPLOT="gnuplot.lang"
NCL="ncl.lang"

# Color themes
GRUVBOX_DARK="gruvbox-dark.xml"

# Go to the ./languages,
# backup and install all the files.
cd ./languages
for f in *.lang
do
    BackupInstall ${f} ${LANG_DIR}
done
cd ..

cd ./styles
for f in *.xml
do
    BackupInstall ${f} ${STYLE_DIR}
done
cd ..
echo "The GtkSourceView is uccessfully baked!"
