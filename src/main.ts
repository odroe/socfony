import { app } from "./runtime";
import { apolloServer } from "./apollo-server";

async function main() {
    await apolloServer.start();
    apolloServer.applyMiddleware({ app, path: '/' });
    
    app.listen(process.env.PORT || 3000)

    console.log(`🚀 Apollo Server is listening on port http://localhost:${process.env.PORT || 3000}`);
}

main();
