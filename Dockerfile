# Build stage - generate static site with MkDocs
FROM python:3.11-alpine AS builder

WORKDIR /docs

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy documentation source files
COPY mkdocs.yml .
COPY docs/ ./docs/

# Build static site
RUN mkdocs build --strict --verbose

# Production stage - serve with nginx (unprivileged nginx runs as user 101, port 8080)
FROM nginxinc/nginx-unprivileged:alpine

# Copy built static files from builder stage
COPY --from=builder /docs/site /usr/share/nginx/html

# Expose port 8080 (unprivileged nginx default)
EXPOSE 8080

# nginx runs in foreground by default in the official image
CMD ["nginx", "-g", "daemon off;"]
