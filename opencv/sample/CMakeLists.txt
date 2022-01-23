cmake_minimum_required(VERSION 2.8)

set(TARGET DisplayImage )
file(GLOB MY_SOURCE src/*.h src/*.cpp)

project( ${TARGET} )

find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )


add_executable( ${TARGET} ${MY_SOURCE} )
target_link_libraries( ${TARGET} ${OpenCV_LIBS} )
