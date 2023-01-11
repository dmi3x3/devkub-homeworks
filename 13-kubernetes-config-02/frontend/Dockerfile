FROM node:lts-buster as builder

RUN mkdir /app

WORKDIR /app

ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json

RUN npm i --lts

ADD . /app

RUN npm --depth 20 update --save caniuse-lite browserslist
#RUN export NODE_OPTIONS=--openssl-legacy-provider
##&& yarn build && yarn install --production --ignore-scripts --prefer-offline
RUN export NODE_OPTIONS=--openssl-legacy-provider && npm run build --lts
RUN rm -rf /app/node_modules

FROM nginx:latest

RUN mkdir /app
WORKDIR /app
COPY --from=builder /app/ /app

RUN mv /app/markup/* /app && rm -rf /app/markup

ADD demo.conf /etc/nginx/conf.d/default.conf
