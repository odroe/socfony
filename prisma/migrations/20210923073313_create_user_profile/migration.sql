-- CreateTable
CREATE TABLE `UserProfile` (
    `userId` CHAR(64) NOT NULL,
    `name` VARCHAR(48),
    `bio` VARCHAR(128),
    `avatar` VARCHAR(128),
    `location` VARCHAR(128),
    `birthday` DATE,
    `gender` ENUM('unknow', 'man', 'woman') NOT NULL DEFAULT 'unknow',

    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
