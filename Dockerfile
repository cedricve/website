FROM mcr.microsoft.com/devcontainers/typescript-node:0-20 as build

WORKDIR /app
COPY website/package.json website/package-lock.json ./
RUN npm install
COPY website .
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]