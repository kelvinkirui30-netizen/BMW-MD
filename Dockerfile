FROM node:lts-buster

# Fix: Set non-interactive mode, remove apt-get upgrade, and add --no-install-recommends
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ffmpeg \
  imagemagick \
  webp && \
  rm -rf /var/lib/apt/lists/*

# Set up the working directory cleanly
WORKDIR /root/BmwMD

# Copy package structures first to leverage Docker build cache
COPY package.json .

# Install PM2 globally and production dependencies
RUN npm i pm2 -g && \
    npm install --legacy-peer-deps

# Copy the rest of your application code
COPY . .

EXPOSE 5000

CMD ["pm2-runtime", "ibrahim.js"]
