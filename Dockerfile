FROM node:lts-bullseye

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ffmpeg \
  imagemagick \
  webp && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /root/BmwMD

COPY package.json .

RUN npm i pm2 -g && \
    npm install --legacy-peer-deps

COPY . .

EXPOSE 5000

CMD ["pm2-runtime", "ibrahim.js"]
