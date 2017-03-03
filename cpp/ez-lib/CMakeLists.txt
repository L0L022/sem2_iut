add_library(ez-lib ez-draw.c ez-draw++.cpp ez-image.c)

find_package(X11)
if (X11_FOUND)
  include_directories(${X11_INCLUDE_DIRS})
  target_link_libraries (ez-lib ${X11_LIBRARIES})
endif (X11_FOUND)
