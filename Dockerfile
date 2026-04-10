# Multi-stage build for IF-EDUprime
FROM node:18-alpine AS builder

WORKDIR /app

# Copy project files
COPY . .

# Install dependencies (if needed for any build process)
RUN npm install 2>/dev/null || true

# Production stage
FROM nginx:alpine

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Copy static files from builder
COPY html /usr/share/nginx/html
COPY css /usr/share/nginx/html/css
COPY js /usr/share/nginx/html/js
COPY jpg /usr/share/nginx/html/jpg
COPY png /usr/share/nginx/html/png
COPY svg /usr/share/nginx/html/svg
COPY img-png /usr/share/nginx/html/img-png
COPY woff /usr/share/nginx/html/woff
COPY woff2 /usr/share/nginx/html/woff2
COPY ttf /usr/share/nginx/html/ttf
COPY Centrale_d\'aide /usr/share/nginx/html/Centrale_d\'aide
COPY IF /usr/share/nginx/html/IF
COPY https_ /usr/share/nginx/html/https_

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
