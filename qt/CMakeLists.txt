add_definitions(-std=c++11)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)

set(Qt5Core_DIR "/var/tmp/Qt/5.8/gcc_64/lib/cmake/Qt5Core/")
set(Qt5Gui_DIR "/var/tmp/Qt/5.8/gcc_64/lib/cmake/Qt5Gui/")
set(Qt5Widgets_DIR "/var/tmp/Qt/5.8/gcc_64/lib/cmake/Qt5Widgets/")

# Find the QtWidgets library
find_package(Qt5Core)
find_package(Qt5Gui)
find_package(Qt5Widgets)

add_subdirectory(killian_shoot)
