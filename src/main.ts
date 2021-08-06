import { app } from "./runtime";
import { apolloServer } from "./apollo-server";

async function main() {
    await apolloServer.start();
    
    const address = await app
    
    /// Register Apollo Server.
    .register(apolloServer.createHandler({
        path: '/',
    }))
    
    /// Listen on port 3000
    .listen(3000);

    console.log(`🚀 Server ready at ${address}`);
}

main();
