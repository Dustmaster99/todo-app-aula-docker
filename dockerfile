#NPM run build
FROM node:22 as builder
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

#NPM run test
FROM node:22-slim
WORKDIR /app
COPY package*.json .
RUN npm install
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD ["node", "dist/main.js"]
