# Run like so:
#
#     docker build . -t demo
#     docker run --rm -ti -p 8080:80/tcp demo
#
FROM node:20-alpine3.17 as ci_step_build
WORKDIR /app

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install

COPY src/ /app/src/
COPY public/ /app/public/
RUN npm run build
RUN npm run test -- --watchAll=false

FROM nginx:1.25.2
COPY --from=ci_step_build /app/build /usr/share/nginx/html
ENTRYPOINT ["nginx", "-g", "daemon off;"]