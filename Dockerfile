# Build dist
FROM node:lts-alpine as builder
WORKDIR /socfony
COPY ./ ./
RUN npm ci
RUN npm run build:prisma
RUN npm run build

# Build prod
FROM node:lts-alpine
RUN apk --no-cache add openssl
WORKDIR /socfony
COPY --from=builder /socfony/dist ./
ENV DATABASE_URL=
EXPOSE 3000

# The `NO_PEER_DEPENDENCY_CHECK=1` skip nexus-prisma pre dependency check.
CMD ["NO_PEER_DEPENDENCY_CHECK=1", "node", "index.js"]
