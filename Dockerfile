
# --- Stage 1: Build & Install Dependencies ---
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

# --- Stage 2: Final Lightweight Runtime ---
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY app.js package.json ./

# Run as a non-root
USER node

EXPOSE 3000

ENV PORT=3000

CMD ["node", "app.js"]
