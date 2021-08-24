-- CreateTable
CREATE TABLE `Setting` (
    `name` VARCHAR(48) NOT NULL,
    `key` VARCHAR(48) NOT NULL,
    `value` JSON NOT NULL,

    INDEX `Setting.name_index`(`name`),
    INDEX `Setting.key_index`(`key`),
    UNIQUE INDEX `Setting.name_key_unique`(`name`, `key`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
