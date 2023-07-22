FROM ros:noetic

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ros-noetic-roscpp \
    ros-noetic-std-msgs \
    vim \
    nmap \
    tree \
    wget \
    unzip

# Set up the ROS environment variables
ENV ROS_MASTER_URI=http://<IP_ADDRESS_OF_MAIN_COMPUTER>:11311
ENV ROS_IP=<IP_ADDRESS_OF_RASPBERRY_PI>



# Allow root to login over ssh and forward graphics over ssh
# Allow for environment variables to be set in ssh
# RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
#     echo "X11UseLocalhost no" >> /etc/ssh/sshd_config && \
#     echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config && \
#     mkdir -p /root/.ssh && \
#     touch /root/.ssh/environment

# Install Saleae Logic application and add to path
RUN cd /opt && \
    wget -O "logic.zip" "http://downloads.saleae.com/logic/1.2.18/Logic+1.2.18+(64-bit).zip" && \
    unzip logic.zip && \
    rm logic.zip && \
    mv "Logic 1.2.18 (64-bit)" "logic" && \
    ln -s /opt/logic/Logic /usr/local/bin/Logic

WORKDIR /root/dev/acoustics
