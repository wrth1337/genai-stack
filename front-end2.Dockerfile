# FROM node:alpine

# WORKDIR /app

# COPY front-end2/package.json .

# RUN npm install

# RUN npm i -g serve

# COPY front-end2/. .

# RUN npm run build

# EXPOSE 8506

# ENTRYPOINT [ "serve", "-s", "dist" ]

FROM node:alpine

WORKDIR /app

COPY front-end2/package.json .

RUN npm install

COPY front-end2/. .

RUN npm run build

EXPOSE 8506

ENTRYPOINT [ "npm", "run", "preview" ]