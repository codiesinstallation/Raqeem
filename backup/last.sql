
ALTER TABLE
    `raqeem`.`type_units` DROP FOREIGN KEY `tu_type_id`,
    DROP FOREIGN KEY `uu_unit_id`;

ALTER TABLE
    `raqeem`.`type_units`
ADD
    CONSTRAINT `tu_type_id` FOREIGN KEY (`type_id`) REFERENCES `raqeem`.`types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD
    CONSTRAINT `uu_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `raqeem`.`units` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE;
