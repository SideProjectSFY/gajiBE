package com.gaji.social.domain.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserFollowId implements Serializable {
    private UUID followerId;
    private UUID followeeId;
}
