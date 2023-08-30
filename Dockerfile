# Run like so:
#
#     docker build . -t demo
#     docker run --rm -ti -p 8080:80/tcp demo
#
FROM nginx:1.25.2

COPY build /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
