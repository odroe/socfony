-- CreateTable
CREATE TABLE `Setting` (
    `name` VARCHAR(48) NOT NULL,
    `key` VARCHAR(48) NOT NULL,
    `value` JSON NOT NULL,

    INDEX `Setting_name_idx`(`name`),
    INDEX `Setting_key_idx`(`key`),
    UNIQUE INDEX `Setting_name_key_key`(`name`, `key`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
