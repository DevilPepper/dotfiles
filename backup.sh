#!/bin/bash

for dir in $(ls -d */ | sed 's#/##'); do
    source .script/backup.sh $(pwd)/$dir
done

