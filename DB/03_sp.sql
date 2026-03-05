USE seating_db;

DROP PROCEDURE IF EXISTS sp_get_employees;
DROP PROCEDURE IF EXISTS sp_get_seats;
DROP PROCEDURE IF EXISTS sp_assign_seat;
DROP PROCEDURE IF EXISTS sp_clear_seat;

DELIMITER $$

CREATE PROCEDURE sp_get_employees()
BEGIN
    SELECT
        EMP_ID AS empId,
        NAME AS name
    FROM Employee;
END$$

CREATE PROCEDURE sp_get_seats()
BEGIN
    SELECT
        s.FLOOR_SEAT_SEQ AS floorSeatSeq,
        s.FLOOR_NO AS floorNo,
        s.SEAT_NO AS seatNo,
        e.EMP_ID AS occupiedEmpId
    FROM SeatingChart s
             LEFT JOIN Employee e
                       ON s.FLOOR_SEAT_SEQ = e.FLOOR_SEAT_SEQ
    ORDER BY s.FLOOR_NO, s.SEAT_NO;
END$$

CREATE PROCEDURE sp_assign_seat(
    IN p_emp_id INT,
    IN p_floor_seat_seq INT
)
BEGIN

    START TRANSACTION;

-- 清掉該員工原本座位
    UPDATE Employee
    SET FLOOR_SEAT_SEQ = NULL
    WHERE EMP_ID = p_emp_id;

-- 如果座位已被佔用，清掉那位員工
    UPDATE Employee
    SET FLOOR_SEAT_SEQ = NULL
    WHERE FLOOR_SEAT_SEQ = p_floor_seat_seq;

-- 指定新座位
    UPDATE Employee
    SET FLOOR_SEAT_SEQ = p_floor_seat_seq
    WHERE EMP_ID = p_emp_id;

    COMMIT;

END$$

CREATE PROCEDURE sp_clear_seat(
    IN p_floor_seat_seq INT
)
BEGIN

    START TRANSACTION;

    UPDATE Employee
    SET FLOOR_SEAT_SEQ = NULL
    WHERE FLOOR_SEAT_SEQ = p_floor_seat_seq;

    COMMIT;

END$$

DELIMITER ;