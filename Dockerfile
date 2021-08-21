# Build dist
FROM node:lts-alpine as builder
WORKDIR /socfony
COPY ./ ./
RUN npm ci --ignore-scripts
RUN npm run build:prisma
RUN npm run build

# Fixed nexus-prisma validate dependencies
# https://github.com/prisma/nexus-prisma/issues/109
# RUN echo "{\"dependencies\": {\"@prisma/client\": \"^2.27.0\"}}" > dist/package.json

# Build prod
FROM node:lts-alpine
RUN apk --no-cache add openssl
WORKDIR /socfony
COPY --from=builder /socfony/dist ./
ENV DATABASE_URL=
EXPOSE 3000
CMD ["node", "index.js"]
