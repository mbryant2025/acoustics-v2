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