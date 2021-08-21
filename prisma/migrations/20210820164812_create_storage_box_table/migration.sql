-- CreateTable
CREATE TABLE `StorageBox` (
    `name` VARCHAR(48) NOT NULL,
    `key` VARCHAR(48) NOT NULL,
    `value` JSON NOT NULL,

    INDEX `StorageBox.name_index`(`name`),
    INDEX `StorageBox.key_index`(`key`),
    UNIQUE INDEX `StorageBox.name_key_unique`(`name`, `key`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
