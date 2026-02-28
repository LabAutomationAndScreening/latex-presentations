# latex-presentations
Tooling for using LaTeX to create posters and presentations along with public examples of lab automation presentations

# First-time setup of Overleaf or updating Overleaf versions

If you are simply looking to start overleaf from this repo skip to [Running Overleaf](#running-overleaf).

1. Clone the repo `git clone https://github.com/overleaf/toolkit.git overleaf`
2. remove the git and .github configuration so we can just commit those files: `rm -rf overleaf/.git overleaf/.github`
3. Set up basic config `bash overleaf/bin/init`. that's gonna use the full sharelatex image...if you want to make a custom one, put a Dockerfile in there and look at the overleaf.rc
4. Change the `OVERLEAF_LISTEN_IP` and `NGINX_HTTP_LISTEN_IP` to `0.0.0.0` in overleaf.rc
5. in the overleaf/.gitignore file, comment out `config/**/*` so config will be saved


# Running overleaf

1. If on Windows, launch a new Ubuntu WSL terminal in VS Code, then `./overleaf/bin/up` (you may need to start Docker Desktop first)
2. Go to http://localhost/launchpad
3. Create a new admin user and log in
4. Go to http://localhost
5. Create a new project or work on an existing one

# How-tos

## Converting Beamer PDFs to PPTX

1. Based on https://github.com/ashafaei/pdf2pptx
2. Clone the repo `git clone https://github.com/ashafaei/pdf2pptx pdf2pptx`
3. remove the git configuration so we can just commit those files: `rm -rf pdf2pptx/.git`
4. Need to install imagemagick (this version worked, but no particular reason to pin to that): `sudo apt-get update && sudo apt-get install -y imagemagick=8:6.9.12.98+dfsg1-5.2build2`
5. May also need to install zip (this version worked, but no particular reason to pin to that): `sudo apt-get update && sudo apt-get install -y zip=3.0-13ubuntu0.2`
6. Tweak the resolution if you want inside pdf2pptx.sh (this has it )
7. Run it `bash ./pdf2pptx/pdf2pptx.sh slas.pdf` (at high resolution and for a long presentation, this could take 3-4 minutes. you can watch for progress in the yourfilename.pdf.temp folder it creates if you're nervous)
