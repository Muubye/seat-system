package com.example.seat.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class SeatRepository {

    private final JdbcTemplate jdbcTemplate;

    public Object getEmployees() {
        return jdbcTemplate.queryForList("CALL sp_get_employees()");
    }

    public Object getSeats() {
        return jdbcTemplate.queryForList("CALL sp_get_seats()");
    }

    public Integer findSeatByEmpId(String empId) {

        String sql = "SELECT FLOOR_SEAT_SEQ FROM Employee WHERE EMP_ID = ?";

        return jdbcTemplate.query(
                sql,
                rs -> rs.next() ? rs.getInt("FLOOR_SEAT_SEQ") : null,
                empId
        );
    }

    public Object assignSeat(String empId, Integer seatSeq) {

        jdbcTemplate.update("CALL sp_assign_seat(?,?)", empId, seatSeq);

        return "success";
    }

    public Object clearSeat(Integer seatSeq) {

        jdbcTemplate.update("CALL sp_clear_seat(?)", seatSeq);

        return "success";
    }
}