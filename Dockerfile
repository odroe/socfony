# Build dist
# FROM node:lts-alpine AS builder
# WORKDIR /socfony
# COPY ./ ./
# RUN npm ci
# RUN npm run build:prisma
# RUN npm run build

# Build prod
# FROM node:lts-alpine
# RUN apk --no-cache add openssl
# WORKDIR /socfony

# COPY --from=builder /socfony/dist ./
# ENV DATABASE_URL=

# # The `NO_PEER_DEPENDENCY_CHECK=1` skip nexus-prisma pre dependency check.
# ENV NO_PEER_DEPENDENCY_CHECK=1

# EXPOSE 3000
# CMD ["node", "index.js"]

# Temporary, formal on the above, but there are several technical problems, no way to keep the package small and normal operation
FROM node:lts-alpine
WORKDIR /socfony
COPY ./ ./

RUN npm ci
RUN npm run build:prisma
RUN npx tsc

# The `NO_PEER_DEPENDENCY_CHECK=1` skip nexus-prisma pre dependency check.
ENV NO_PEER_DEPENDENCY_CHECK=1
ENV DATABASE_URL=

EXPOSE 3000
CMD ["node", "dist/main.js"]
