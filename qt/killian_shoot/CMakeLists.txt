file(GLOB SRC *.cpp)
add_executable(killian_shoot WIN32 ${SRC})
target_link_libraries(killian_shoot Qt5::Widgets)
