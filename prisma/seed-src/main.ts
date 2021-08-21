import { prisma } from "../../services/prisma";
import * as seeds from "./seeds";

export async function main() {
  const seeders = Object.values<Function>(seeds).filter(
    (seeder) => typeof seeder === "function"
  );

  console.log(`${seeders.length} seeders need run:`);

  let seedersCount = 0;

  for await (const seeder of seeders) {
    seedersCount++;
    process.stdout.write(
      `  [${seedersCount}/${seeders.length}] Seeding ${seeder.name}...`
    );

    try {
      await seeder(prisma);

      process.stdout.clearLine(-1);
      process.stdout.cursorTo(0);
      process.stdout.write(
        `  [${seedersCount}/${seeders.length}] Seeded ${seeder.name}.`
      );
    } catch (e) {
      process.stdout.clearLine(-1);
      process.stdout.cursorTo(0);
      process.stdout.write(
        `  [${seedersCount}/${seeders.length}] Failed to seed ${seeder.name}, Error: ${e.message}`
      );
    }
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
