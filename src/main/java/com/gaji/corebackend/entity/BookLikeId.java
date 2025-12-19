package com.gaji.corebackend.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookLikeId implements Serializable {
    private UUID userId;
    private UUID bookId;
}
