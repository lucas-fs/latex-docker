#!/bin/bash

CONTAINER_NAME=latex
IMAGE_REPO=lucasfs/latex
IMAGE_TAG=texlive

envstart() {
    if [ -z "$1" ]
    then
        echo "No project directory supplied!"
        echo "Finished"
        exit 1
    else
        echo "Starting latex enviroment based on [$IMAGE_REPO:$IMAGE_TAG] Docker image..."
        docker run --name latex -v "$1":/project -dt "$IMAGE_REPO:$IMAGE_TAG" bash
        echo "Done!"
    fi
}

envstatus() {
    echo "Latex enviroment status:"
    is_running=$(docker ps --filter "name=$CONTAINER_NAME" --filter status=running -q)
    if [ -z "$is_running" ]
    then
        echo "Enviroment $CONTAINER_NAME is not running"
    else
        echo -e "\nRunning \n"
        docker ps --filter "name=$CONTAINER_NAME"
    fi
}

envkill() {
    is_running=$(docker ps --filter "name=$CONTAINER_NAME")
    if [ -z "$is_running" ]
    then
        echo "Enviroment $CONTAINER_NAME not found"
    else
        echo "Killing the environment..."
        docker container rm $CONTAINER_NAME -f
    fi
}

compile() {
    if [ -z "$1" ]
    then
        echo "No source file supplied!"
        echo "Finished"
        exit 1
    else
        echo "Create PDF file from $1"
        is_running=$(docker ps --filter "name=$CONTAINER_NAME" --filter status=running -q)
        if [ -z "$is_running" ]
        then
            echo "Enviroment $CONTAINER_NAME is not running"
        else
            docker exec -it $CONTAINER_NAME latexmk "$1"
        fi
    fi
}

makepdf() {
    if [ -z "$1" ]
    then
        echo "No source file supplied!"
        echo "Finished"
        exit 1
    else
        echo "Create PDF file from $1"
        is_running=$(docker ps --filter "name=$CONTAINER_NAME" --filter status=running -q)
        if [ -z "$is_running" ]
        then
            echo "Enviroment $CONTAINER_NAME is not running"
        else
            docker exec -it $CONTAINER_NAME latexmk -f "$1" -silent -pdf
        fi
    fi
}

cleantex() {
    if [ -z "$1" ]
    then
        echo "No source file supplied!"
        echo "Finished"
        exit 1
    else
        is_running=$(docker ps --filter "name=$CONTAINER_NAME" --filter status=running -q)
        if [ -z "$is_running" ]
        then
            echo "Enviroment $CONTAINER_NAME is not running"
        else
            echo "Cleaning auxiliary files and log files..."
            docker exec -it $CONTAINER_NAME latexmk -c "$1"
            docker exec -it $CONTAINER_NAME bash -c "rm *.ps *.log *.aux *.out *.dvi *.bbl *.blg *.lof *.lot *.toc *.fls *.fdb_latexmk"
        fi
    fi
}

help() {

    echo -e "\nUsage:    dockertex [COMMAND] <ARGUMENT> \n"
    echo -e "Commands:\n"
    echo -e "  envstart <dir>        Start Latex Docker enviroment"
    echo -e "                        <dir>: Absolute path of project directory containing Latex files \n"
    echo -e "  envstatus             Show status of Latex Docker enviroment container \n"
    echo -e "  envkill               Kill and remove the Latex Docker enviroment container \n"
    echo -e "  compile <file>        Compiles the Latex file passed by argument"
    echo -e "                        <file>: Latex file name \n"
    echo -e "  makepdf <file>        Generates a PDF file from latex file passed by argument"
    echo -e "                        <file>: Latex file name \n"
    echo -e "  cleantex <file>       Clean all temporary files used in latex file compilation"
    echo -e "                        <file>: Latex file name \n"
    echo -e "  help                  Show this current help information \n"
}

if declare -f "$1" > /dev/null
then
  "$@"
else
    if [ -z "$1" ]
    then
        echo -e "Expected a command for dockertex! \n"
    else
        echo -e "Function '$1' not found! \n"
    fi
    help
    exit 1
fi