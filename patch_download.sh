#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Downloading $line....\n"
    patchNo=$(echo $line| cut -c6-10)
    svn export "https://svn.wso2.com/wso2/custom/projects/projects/carbon/wilkes/patches/patch${patchNo}/WSO2-CARBON-PATCH-4.4.0-${patchNo}.zip" 
done < "$1"
