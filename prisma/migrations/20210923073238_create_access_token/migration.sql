-- CreateTable
CREATE TABLE `AccessToken` (
    `token` VARCHAR(128) NOT NULL,
    `userId` CHAR(64) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `expiredAt` DATETIME(3) NOT NULL,
    `refreshExpiredAt` DATETIME(3) NOT NULL,

    INDEX `AccessToken_userId_idx`(`userId`),
    PRIMARY KEY (`token`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
