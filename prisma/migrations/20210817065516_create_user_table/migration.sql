-- CreateTable
CREATE TABLE `User` (
    `id` CHAR(64) NOT NULL,
    `name` VARCHAR(48),
    `email` VARCHAR(128),
    `mobile` VARCHAR(15),
    `password` VARCHAR(128),
    `registeredAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `User.name_unique`(`name`),
    UNIQUE INDEX `User.email_unique`(`email`),
    UNIQUE INDEX `User.mobile_unique`(`mobile`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
