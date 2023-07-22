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