#!/bin/bash

for share in $(find . -type d 2>&-); do
        touch $share/nonexistenfile 2>&-
done
find . -name nonexistenfile 2>&-
