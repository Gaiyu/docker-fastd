docker build -t fastd:r21 .

# docker run -d --network=host fastd:r21
# docker run -d --cap-add NET_ADMIN --cap-add NET_RAW fastd:r21
# docker run -d --cap-add NET_ADMIN --cap-add NET_RAW -p 7000:7000/udp fastd:r21

# docker save fastd:r21 -o fastd.r21.tar
