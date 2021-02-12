# latex-docker

A simple way to install and use a Latex environment without having to install many packages and dependencies in the operating system.

```
Usage:    dockertex [COMMAND] <ARGUMENT> 

Commands:

  envstart <dir>        Start Latex Docker enviroment
                        <dir>: Absolute path of project directory containing Latex files 

  envstatus             Show status of Latex Docker enviroment container 

  envkill               Kill and remove the Latex Docker enviroment container 

  compile <file>        Compiles the Latex file passed by argument
                        <file>: Latex file name 

  makepdf <file>        Generates a PDF file from latex file passed by argument
                        <file>: Latex file name 

  cleantex <file>       Clean all temporary files used in latex file compilation
                        <file>: Latex file name 

  help                  Show this current help information 

```

## Usage samples

### Create an enviroment

Create a Latex enviroment with the "textfiles" as latex project directory:

```
./dockertex.sh envstart $PWD/texfiles/
```

### Genereate PDF from Latex file

Create a PDF file from the .tex passed by argument. The Latex file must be in project directory, otherwise will be necessary to pass the absolute file path.

```
./dockertex.sh makepdf sample.pdf
```

### Clean project

Clean temporary files generated in the Latex file compilation.

```
./dockertex.sh cleantex sample.tex
```
