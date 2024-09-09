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
@Table(name="cats")
public class Cat {
    @Id
    @Column(name = "cat_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne
    @JoinColumn(name = "advertisement_id")
    private Advertisement advertisement;
    @Column(length = 15)
    private String name;
    private Integer age;
    private Integer weight;
    @Enumerated(EnumType.STRING)
    @Column(length = 7)
    private GenderEnum gender;
    @Enumerated(EnumType.STRING)
    @Column(length = 25)
    private RegionEnum region;
    @Enumerated(EnumType.STRING)
    @Column(length = 12)
    private CharacterEnum character;
    @Enumerated(EnumType.STRING)
    @Column(length = 7)
    private ActivityEnum activity;
    private Boolean vaccinated;
    private Boolean sterilized;
    @Column(name = "child_friendly")
    private Boolean childFriendly;
}
