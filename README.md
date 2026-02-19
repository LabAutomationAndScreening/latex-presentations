# latex-presentations
Tooling for using LaTeX to create posters and presentations along with public examples of lab automation presentations

Set up overleaf
#. Clone the repo `git clone https://github.com/overleaf/toolkit.git overleaf`
#. remove the git configuration so we can just commit those files: `rm -rf overleaf/.git`
#. Set up basic config `sh overleaf/bin/init`. that's gonna use the full sharelatex image...if you want to make a custom one, put a Dockerfile in there and look at the overleaf.rc
#. Change the `OVERLEAF_LISTEN_IP` and `NGINX_HTTP_LISTEN_IP` to `0.0.0.0`
#. in the overleaf/.gitignore file, comment out `config/**/*` so config will be saved
#. Note: file persistence isn't set up (not sure how to do that), so make sure to save your overleaf projects to zip file frequently.   ...or maybe it is now that the data paths in the rc file have been updated...? unclear

Running overleaf
#. If on Windows, launch a new Ubuntu WSL terminal in VS Code, then `./overleaf/bin/up` (you may need to start Docker Desktop first)
#. Go to http://localhost/launchpad


Converting Beamer PDFs to PPTX
#. Based on https://github.com/ashafaei/pdf2pptx
#. Clone the repo `git clone https://github.com/ashafaei/pdf2pptx pdf2pptx`
#. remove the git configuration so we can just commit those files: `rm -rf pdf2pptx/.git`
#. Need to install imagemagick (this version worked, but no particular reason to pin to that): `sudo apt-get update && sudo apt-get install -y imagemagick=8:6.9.12.98+dfsg1-5.2build2`
#. Tweak the resolution if you want inside pdf2pptx.sh
#. Run it `bash ./pdf2pptx/pdf2pptx.sh slas.pdf` (at high resolution and for a long presentation, this could take 3-4 minutes. you can watch for progress in the yourfilename.pdf.temp folder it creates if you're nervous)
