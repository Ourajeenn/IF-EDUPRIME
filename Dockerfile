FROM nginx:alpine

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy static website files
COPY . /usr/share/nginx/html/

# Remove non-web files from nginx root
RUN rm -rf /usr/share/nginx/html/.git \
           /usr/share/nginx/html/.vscode \
           /usr/share/nginx/html/Dockerfile \
           /usr/share/nginx/html/docker-compose.yml \
           /usr/share/nginx/html/nginx.conf \
           /usr/share/nginx/html/default.conf \
           /usr/share/nginx/html/Makefile \
           /usr/share/nginx/html/DOCKER-README.md

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
