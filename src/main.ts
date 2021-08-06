import { app } from "./runtime";
import { apolloServer } from "./apollo-server";

async function main() {
    await apolloServer.start();
    
    await app.register(apolloServer.createHandler({
        path: '/',
    }));

    const address = await app.listen(3000);
    console.log(`🚀 Listening on ${address}`);
}

main();
