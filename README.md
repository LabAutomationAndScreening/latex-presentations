# latex-presentations
Tooling for using LaTeX to create posters and presentations along with public examples of lab automation presentations

# First-time setup of Overleaf or updating Overleaf versions

If you are simply looking to start overleaf from this repo skip to [Running Overleaf](#running-overleaf).

1. Run the following to clone the repo at a given version, cleanup .git dirs and setup basic config `bash overleaf/bin/init`. that's gonna use the full sharelatex image...if you want to make a custom one, put a Dockerfile in there and look at the overleaf.rc

```bash
git clone https://github.com/overleaf/toolkit.git overleaf
cd overleaf
git checkout 9280a93c4757e8d8b32e2228c66cc46fc7b835ae # v6.1.2
cd ..
rm -rf overleaf/.git overleaf/.github
bash overleaf/bin/init
```

2. Change the `OVERLEAF_LISTEN_IP` and `NGINX_HTTP_LISTEN_IP` to `0.0.0.0` in overleaf.rc
3. in the overleaf/.gitignore file, comment out `config/**/*` so config will be saved

> [!NOTE]
> File persistence isn't set up (not sure how to do that), so make sure to save your overleaf projects to zip file frequently. ...or maybe it is now that the data paths in the rc file have been updated...? unclear

# Running overleaf

1. If on Windows, launch a new Ubuntu WSL terminal in VS Code, then `./overleaf/bin/up` (you may need to start Docker Desktop first)
2. Go to http://localhost/launchpad
3. Create a new admin user and log in
4. Go to http://localhost
5. Create a new project or work on an existing one

# How-tos

## Compiling locally (without Overleaf)

`compile.sh` compiles a project inside a pinned TeX Live Docker image, so Docker is the only thing you need installed. CI runs the same script on every PR and uploads the PDFs and PPTX as workflow artifacts.

```bash
./compile.sh projects/presentations/<name>             # every top-level .tex -> <name>/build/*.pdf, plus build/main.pptx
./compile.sh projects/presentations/<name> --pdf-only  # skip the PPTX
./compile.sh projects/presentations/<name>/main.tex    # only that file, PDF only (fastest for iterating)
```

- Every top-level `.tex` file in a project folder is compiled as its own document, so keep `\input` fragments in a subfolder.
- A project with a `main.tex` also gets `build/main.pptx`, built by `pdf2pptx/` (one full-slide image per PDF page, so clicking through reproduces Beamer overlays).
- A Beamer deck can add a two-line `handout.tex` (see the SLAS2026 presentation) to get `build/handout.pdf` with overlays collapsed to one page per frame.
- A project that needs a different engine sets it in a `latexmkrc` in its folder (see the SLAS2026 poster, which needs LuaLaTeX for `fontspec`).
