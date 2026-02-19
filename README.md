# latex-presentations
Tooling for using LaTeX to create posters and presentations along with public examples of lab automation presentations

Set up overleaf
#. Clone the repo `git clone https://github.com/overleaf/toolkit.git overleaf`
#. remove the git configuration so we can just commit those files: `rm -rf overleaf/.git`
#. Set up basic config `sh overleaf/bin/init`. that's gonna use the full sharelatex image...if you want to make a custom one, put a Dockerfile in there and look at the overleaf.rc
#. Change the `OVERLEAF_LISTEN_IP` and `NGINX_HTTP_LISTEN_IP` to `0.0.0.0`
#. in the overleaf/.gitignore file, comment out `config/**/*` so config will be saved
#. Note: file persistence isn't set up (not sure how to do that), so make sure to save your overleaf projects to zip file frequently

Running overleaf
#. If on Windows, launch a new Ubuntu WSL terminal in VS Code, then `./overleaf/bin/up` (you may need to start Docker Desktop first)