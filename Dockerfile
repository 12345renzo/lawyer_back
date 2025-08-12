# Etapa base común
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./
COPY tsconfig*.json ./
COPY nest-cli.json ./

# Etapa de desarrollo
FROM base AS dev
ENV NODE_ENV=development
# Instala todas las dependencias (incluyendo devDependencies)
RUN npm install
COPY . .
CMD ["npm", "run", "start:dev"]

# Etapa de construcción (builder)
FROM base AS builder
ENV NODE_ENV=production
# Instala tanto dependencias normales como de desarrollo para el build
RUN npm install
COPY src ./src
COPY test ./test
RUN npx nest build

# Etapa de producción
FROM base AS prod
ENV NODE_ENV=production
RUN npm ci --only=production
COPY --from=builder /app/dist ./dist
EXPOSE 4000
CMD ["node", "dist/main"]