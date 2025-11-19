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

# Production stage - serve with nginx
FROM nginx:alpine

# Copy built static files from builder stage
COPY --from=builder /docs/site /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# nginx runs in foreground by default in the official image
CMD ["nginx", "-g", "daemon off;"]
