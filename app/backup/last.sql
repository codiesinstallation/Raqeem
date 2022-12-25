
ALTER TABLE
    `raqeem`.`bill_types`
ADD
    COLUMN `type_num` INT(11) NULL DEFAULT 0 AFTER `type_discount_percent`,
ADD
    COLUMN `uuid` VARCHAR(45) NULL DEFAULT NULL AFTER `type_num`;

ALTER TABLE `raqeem`.`users`
ADD COLUMN `delete_bill` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;

ALTER TABLE `raqeem`.`users`
ADD COLUMN `delete_reserved_type` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;


ALTER TABLE `raqeem`.`users`
ADD COLUMN `resend` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;


ALTER TABLE `raqeem`.`users`
ADD COLUMN `change_type_in_kitchen` TINYINT(1) NULL DEFAULT 0 AFTER `pin_code`;


