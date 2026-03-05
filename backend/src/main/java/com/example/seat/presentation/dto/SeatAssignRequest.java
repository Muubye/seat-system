package com.example.seat.presentation.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class SeatAssignRequest {

    @NotNull
    @Size(min = 5, max = 5)
    private String empId;

    @NotNull
    private Integer floorSeatSeq;
}