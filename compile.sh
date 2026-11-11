#!/usr/bin/env bash
set -euo pipefail

# Compiles a project inside a pinned TeX Live container, so Docker is the only host requirement.
# CI runs this same script.
#
# Usage:
#   ./compile.sh projects/presentations/<name>             # every top-level .tex -> <name>/build/*.pdf,
#                                                          # plus build/main.pptx when the project has a main.tex
#   ./compile.sh projects/presentations/<name> --pdf-only  # skip the PPTX
#   ./compile.sh projects/presentations/<name>/main.tex    # only that file, PDF only (fast iteration)
#
# Every top-level .tex file in a project folder is a root document, so put \input fragments in a
# subfolder. A project can choose its engine with a latexmkrc in its folder (see the poster's).
#
# Override the image with LATEX_IMAGE. texlive doesn't publish versioned tags, so it's pinned by digest.
IMAGE="${LATEX_IMAGE:-texlive/texlive@sha256:62927d994f09aea455c8ea9da034af14764f9e2276a616b413545e7cec69c06b}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  echo "Usage: ./compile.sh <project-dir|file.tex> [--pdf-only]" >&2
  exit 1
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
fi
TARGET="$1"
BUILD_PPTX=1
case "${2:-}" in
  --pdf-only) BUILD_PPTX=0 ;;
  "") ;;
  *) usage ;;
esac

shopt -s nullglob
if [[ -d "$TARGET" ]]; then
  PROJECT_DIR="$TARGET"
  SOURCES=("$PROJECT_DIR"/*.tex)
elif [[ -f "$TARGET" && "$TARGET" == *.tex ]]; then
  PROJECT_DIR="$(dirname "$TARGET")"
  SOURCES=("$TARGET")
  BUILD_PPTX=0
else
  echo "Error: '$TARGET' is neither a folder nor a .tex file" >&2
  usage
fi

if [[ ${#SOURCES[@]} -eq 0 ]]; then
  echo "Error: no .tex files found in '$PROJECT_DIR'" >&2
  exit 1
fi
SOURCES=("${SOURCES[@]##*/}")

PROJECT_ABS="$(cd "$PROJECT_DIR" && pwd)"
PROJECT_REL="${PROJECT_ABS#"$REPO_ROOT"/}"
if [[ "$PROJECT_REL" == "$PROJECT_ABS" ]]; then
  echo "Error: '$PROJECT_DIR' is not inside $REPO_ROOT" >&2
  exit 1
fi

in_container() {
  # The image's home dir is only writable by uid 1000, so any other uid (e.g. CI runners) needs
  # a writable HOME for LuaLaTeX's font cache.
  docker run --rm \
    --user "$(id -u):$(id -g)" \
    -e HOME=/tmp \
    -v "$REPO_ROOT":/workdir \
    -w "/workdir/$PROJECT_REL" \
    "$IMAGE" \
    "$@"
}

in_container latexmk \
  -pdf \
  -interaction=nonstopmode \
  -halt-on-error \
  -outdir=build \
  -auxdir=build \
  "${SOURCES[@]}"
for tex in "${SOURCES[@]}"; do
  echo "Built PDF: $PROJECT_DIR/build/${tex%.tex}.pdf"
done

if [[ "$BUILD_PPTX" == 1 && -f "$PROJECT_DIR/main.tex" ]]; then
  in_container bash /workdir/pdf2pptx/pdf2pptx.sh build/main.pdf > /dev/null
  echo "Built PPTX: $PROJECT_DIR/build/main.pptx"
fi
