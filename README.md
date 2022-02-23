<a href="https://odroe.com">
  <img align="right" width="120px" src="graphs/socfony.png" alt="Socfony Logo">
</a>

Socfony is an open source social application, and basic security modules and social function modules have been preset in the software. Whether it is to deploy Socfony directly or as a basis for program development is wonderful.

- [Server](https://github.com/socfony/server) - GraphQL server side of Socfony.
- [App](https://github.com/socfony/app) - Using Flutter develop Socfony app.

## Get Started

1. Clone the repository.

   ```bash
   git clone https://github.com/socfony/server
   ```

2. Install dependencies.

   ```bash
   cd server
   npm install
   ```

### Configuration

Copy the configuration file to the server directory.

```bash
cat .env.example > .env
```

### Database

Create tables and insert data.

```bash
npx prisma db push
```

### Run server

```bash
npm run start
```

## Documentation

TODO. Website: [https://odroe.com](https://odroe.com)

## License

The BSD 3-Clause License.
