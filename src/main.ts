import { app } from "./runtime";
import { apolloServer } from "./apollo-server";

// Create the main app runtime.
async function main() {
    // Start Apollo server.
    await apolloServer.start();
    
    // Get runtime address.
    const address = await app
    
    /// Register Apollo Server.
    .register(apolloServer.createHandler({
        path: '/',
    }))
    
    /// Listen on port 3000
    .listen(3000);

    // Log the address of the server
    console.log(`🚀 Server ready at ${address}`);
}

// Run it!
main();
