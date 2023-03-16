#!/bin/bash

SUCCESS=0
executable="./etapa4"
echo "STARTING OFFICIAL TEST CASES"

for file in ../Etapa4/testes_E4/*
    do
    ./etapa4 < "$file"
    result=$?

    print="\n\n FROM:${file}"
    echo "$print\n"

done