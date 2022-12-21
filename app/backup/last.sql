
ALTER TABLE
    `raqeem`.`type_units` DROP FOREIGN KEY `tu_type_id`,
    DROP FOREIGN KEY `uu_unit_id`;

ALTER TABLE
    `raqeem`.`type_units`
ADD
    CONSTRAINT `tu_type_id` FOREIGN KEY (`type_id`) REFERENCES `raqeem`.`types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD
    CONSTRAINT `uu_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `raqeem`.`units` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;




ALTER TABLE `raqeem`.`users`
ADD COLUMN `delete_bill` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;

ALTER TABLE `raqeem`.`users`
ADD COLUMN `delete_reserved_type` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;


ALTER TABLE `raqeem`.`users`
ADD COLUMN `resend` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;


ALTER TABLE `raqeem`.`users`
ADD COLUMN `change_type_in_kitchen` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;


