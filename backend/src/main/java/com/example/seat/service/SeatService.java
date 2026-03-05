package com.example.seat.service;

import com.example.seat.presentation.dto.SeatAssignRequest;
import com.example.seat.repository.SeatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class SeatService {

    private final SeatRepository seatRepository;

    public Object getEmployees() {
        return seatRepository.getEmployees();
    }

    public Object getSeats() {
        return seatRepository.getSeats();
    }

    @Transactional
    public Object assignSeat(SeatAssignRequest req) {

        return seatRepository.assignSeat(req.getEmpId(), req.getFloorSeatSeq());
    }

    public Object clearSeat(Integer floorSeatSeq) {
        return seatRepository.clearSeat(floorSeatSeq);
    }
}