# Docker Setup

In the directory of the Dockerfile run

```bash
sudo docker build --platform linux/x86_64 -t acoustics .
```

To run a container on the Pi

```bash
docker run --network host --privileged --platform linux/amd64 -it acoustics
```

To compile the code

```bash
cd /root/dev/acoustics
source /opt/ros/noetic/setup.bash
catkin_make
./devel/setup.bash
```

# Project Setup

The following steps were completed to setup the `catkin_ws` and a `sample_node` package.

Create workspace

```bash
mkdir -p catkin_ws/src
cd catkin_ws
catkin_make
```

## Create a sample package

```bash
cd src
catkin_create_pkg sample_node roscpp std_msgs
```

Inside the sample_node/src folder, create `sample_node.cc` file containing the sample code below:

```c++
#include <ros/ros.h>
#include <std_msgs/String.h>

// Callback function for the subscriber
void messageCallback(const std_msgs::String::ConstPtr& msg)
{
  ROS_INFO("Received message: %s", msg->data.c_str());
}

int main(int argc, char** argv)
{
  // Initialize the ROS node
  ros::init(argc, argv, "sample_node");

  // Create a ROS node handle
  ros::NodeHandle nh;

  // Create a publisher on the "chatter" topic
  ros::Publisher pub = nh.advertise<std_msgs::String>("chatter", 10);

  // Create a subscriber on the "chatter" topic
  ros::Subscriber sub = nh.subscribe("chatter", 10, messageCallback);

  // Set the loop rate (10 Hz)
  ros::Rate loop_rate(10);

  int count = 0;
  while (ros::ok())
  {
    // Create a message object
    std_msgs::String msg;
    msg.data = "Hello, world! " + std::to_string(count);

    // Publish the message
    pub.publish(msg);

    // Spin once to process callbacks
    ros::spinOnce();

    // Sleep to maintain the loop rate
    loop_rate.sleep();

    ++count;
  }

  return 0;
}
```

Create the launch file in the `sample_node` folder

```bash
cd sample_node
mkdir launch
touch launch/sample_node.launch
```

Edit the launch file to contain the follwing:

```bash
<launch>
  <node pkg="sample_node" type="sample_node" name="sample_node" output="screen">
  </node>
</launch>
```

Edit the `sample_node/CMakeLists.txt` to contain the following:

```cmake
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
```

In the `catkin_ws` folder, run
```bash
catkin_make
source devel/setup.bash
```

Now, the package can be launched as follows:

```bash
roslaunch sample_node sample_node.launch```

