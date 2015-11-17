#!/bin/bash

if [[ -f $1 ]]; then
    echo [ $(date +%H:%M:%S) ] Using file $1
else
    echo "File does't exist!"
    exit
fi

# Lastmod 0 so we always render when started.
lastmod=0

while true; do
    # Get the last modifcation of the file.
    mod=$(stat -c %Y ${1})
    # If the file has been modified since last time.
    if [[ mod -gt lastmod ]]; then
        # Print the time.
        echo [ $(date +%H:%M:%S) ] Generating PDF.
        # Render.
        pandoc $1 -o ${1%.md}.pdf
        echo [ $(date +%H:%M:%S) ] Done!
    fi
    # Update the last mod time.
    lastmod=${mod}
    # Sleep for a bit to lighten the load.
    sleep 1
done
