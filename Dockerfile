# Production build dockerfile. Multi-step process for using multiple docker hub images

# Build phase - build Node modules
FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# As this is the production build, we can copy everything because we won't be changing as much
COPY . .
RUN npm run build

# Run phase. Start up nginx
FROM nginx
# Need to open port 80
EXPOSE 80
# Specify a phase to copy from    Destination is found on nginx documentation
COPY --from=builder /app/build /usr/share/nginx/html
# No need to run nas nginx will start when the contaienr starts anyways