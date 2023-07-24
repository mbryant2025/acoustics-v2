cmake_minimum_required(VERSION 3.0.2)
project(sample_node)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
)

catkin_package()

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(sample_node src/sample_node.cc)
target_link_libraries(sample_node ${catkin_LIBRARIES})

install(TARGETS sample_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(FILES launch/sample_node.launch
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/launch)

