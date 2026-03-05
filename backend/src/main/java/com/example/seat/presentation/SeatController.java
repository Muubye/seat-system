package com.example.seat.presentation;

import com.example.seat.presentation.dto.SeatAssignRequest;
import com.example.seat.service.SeatService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;

@CrossOrigin
@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class SeatController {

    private final SeatService seatService;

    //員工列表
    @GetMapping("/employees")
    public Object getEmployees() {
        return seatService.getEmployees();
    }

    //座位列表
    @GetMapping("/seats")
    public Object getSeats() {
        return seatService.getSeats();
    }

    //指派座位
    @PostMapping("/seat/assign")
    public Object assignSeat(@Valid @RequestBody SeatAssignRequest req) {
        return seatService.assignSeat(req);
    }

    //清除座位
    @PostMapping("/seat/clear")
    public Object clearSeat(@RequestBody SeatAssignRequest req) {
        return seatService.clearSeat(req.getFloorSeatSeq());
    }
}