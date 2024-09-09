package com.khpi.mvc.models;

import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import lombok.*;

@Entity
@EqualsAndHashCode(of = {"phoneNumber", "telegramUsername"})
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
@Table(name="contact_info")
public class ContactInfo {
    @Id
    @Column(name = "contact_info_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(length = 20)
    @Nullable
    private String phoneNumber;
    @Column(length = 30)
    @Nullable
    private String telegramUsername;
}
