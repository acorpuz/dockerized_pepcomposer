#!/bin/bash
# #############################################################################
# Script to correctly apply permissions and ownership to the pepcomposer 
# directory.
# The script assumes the standard pepcomposer layout.
#
# Parameters: path to pepcomposer directory
#
# ##############################################################################

showuse () {
    echo -e "Pass the path to the pepcomposer directory.\n" \
	 "\t- Ownership will be set to www-data (GID/UID 33 on debian)\n" \
	 "\t- Permissions will be set to 755 for directories and 644 for files"
}

# We need one parameter (the username), check for it...
if [ ! $# -eq 1 ]; then
    showuse
    exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
    pep_path="$1"

    # check if path exists
    if [ -e "$pep_path" ]; then

	    # set file permissions
	    find "$pep_path" -type d -exec chmod 755 {} \;
		find "$pep_path" -type f -exec chmod 644 {} \;

		# set ownership
		chown -R 33:33 "$pep_path"
		chgrp -R root "${pep_path}/logs"

		# apply correct execute bits
		find "${pep_path}/scripts" -type f -exec chmod 744 {} \;
	else
		echo "Path ${pep_path} not found."
    fi
else
	echo "Please run as root"
fi
