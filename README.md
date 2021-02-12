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

## Use with VS Code

1. Install VSCode extension LaTeX Workshop. (Ctrl+P) and paste the following command:

```
ext install James-Yu.latex-workshop
```

2. Set some configurations for the extention. Open the VSCode *settings.json* and append the following configs:

```
    // latex
    "latex-workshop.docker.enabled": true,
    "latex-workshop.latex.outDir": "./out",
    "latex-workshop.synctex.afterBuild.enabled": true,
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.docker.image.latex": "lucasfs/latex:texlive-full"
```

\* The Docker image and the outDir can be defined as you preferences.

3. At this point you already can use the environment normally with VSCode.

## Extend Docker images

You may need a specific package depending on your project. In such cases you can extend one of the available Docker images and install the desired packages. Here is an example of a Dockerfile that extends one of the base Docker images:

```
FROM lucasfs/latex:texlive

USER root

# Install some packages or dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    abntex \
    texlive-latex-extra \
    && rm -rf /var/lib/apt/lists/*

USER latex
```

After build make sure the correct Docker image is given in LaTeX Workshop settings.



