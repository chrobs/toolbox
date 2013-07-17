# My everyday toolbox

This is a collection of some private helpers. The tools are written in various languages (mostly ruby or bash) and may solve some small tasks for you.

Comments, suggestions and improvements are welcome =)


## List of included tools
===
### jigl/
* **jigl-gallery-by-date.rb** - creates jigl gallery.dat with images sorted by original creation date<br>
  - takes pictures (*.(jpg|JPG|jpeg|JPEG) from directory given in the first argument
  - sort the pics by EXIF original creation date(via the debian tool "exiv2")
  - ask TITLEBAR, TITLE, HEADER & FOOTER names for resulting HTML files
  - writes the complete gallery.dat file for jigl gallery creation
