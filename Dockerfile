# Stage 1: Build
FROM node:18-slim AS builder

WORKDIR /app
COPY app/package*.json ./
RUN npm install --only=production

COPY app .

# Stage 2: Runtime
FROM node:18-slim

WORKDIR /app

# Copy only required files
COPY --from=builder /app .

# Create user
RUN useradd -m appuser
USER appuser

EXPOSE 3000

CMD ["node", "index.js"]
