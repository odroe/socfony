-- CreateTable
CREATE TABLE `User` (
    `id` CHAR(64) NOT NULL,
    `name` VARCHAR(48),
    `email` VARCHAR(128),
    `phone` VARCHAR(15),
    `registeredAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `User_name_key`(`name`),
    UNIQUE INDEX `User_email_key`(`email`),
    UNIQUE INDEX `User_phone_key`(`phone`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
