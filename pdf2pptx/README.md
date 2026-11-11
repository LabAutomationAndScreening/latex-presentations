# pdf2pptx
Convert your (Beamer) PDF slides to (Powerpoint) PPTX

> [!NOTE]
> Vendored from https://github.com/ashafaei/pdf2pptx and modified to rasterize pages with Ghostscript instead of
> ImageMagick, so it runs inside the same TeX Live image as the repo's `compile.sh` (which has `gs`, `zip` and `perl`).
> Run it through `compile.sh` rather than directly.

So you don't like using Powerpoint and would rather use Latex/Beamer to make your slides,
however, you have a fancy Surface and you want to use the pen during the presentation? Here is my solution.

This script gets a PDF file as input and generates a Powerpoint PPTX file while preserving the format of the original PDF. Theoretically all PDF files, regardless of the original generator, can be converted to PPTX slides with this (not tested though).

Simply explained, I convert all the slides to high-quality image files first, and then push them into a Powerpoint project as a slide.

# How to run
* Execute `./pdf2pptx.sh test.pdf` to generate a `test.pdf.pptx` file  (replace `test.pdf` with your filename).
* By default the output powerpoint project is in the widescreen mode. If your slides are not for widescreen you can alternatively run `./pdf2pptx.sh test.pdf notwide` to generate a 4:3 standard PPTX project.

# Dependencies
* `gs` from [Ghostscript](https://www.ghostscript.com/)
* `zip` and `sed`
* (Optional) `perl`, `python`, or `ruby` if you use a symlink to pdf2pptx.sh

# Acknowledgement
Thanks to [Melissa O'Neill](https://www.cs.hmc.edu/~oneill/freesoftware/pdftokeynote.html) for providing a Pdf2Keynote tool for mac which has motivated this small project!
