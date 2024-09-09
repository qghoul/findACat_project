package com.khpi.mvc.models;
import com.khpi.mvc.models.enums.*;
import lombok.*;
import jakarta.persistence.*;

@Entity
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
@Table(name="complaints")
public class Complaint {
    @Id
    @Column(name = "complaint_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.MERGE, CascadeType.REMOVE})
    @JoinColumn(name = "advertisement_id")
    private Advertisement advertisement;
    @ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.REMOVE})
    @JoinColumn(name = "user_id")
    private User user;
    private String reason;
}
