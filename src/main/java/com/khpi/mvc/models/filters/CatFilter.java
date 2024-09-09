package com.khpi.mvc.models.filters;

import com.khpi.mvc.models.enums.*;
import lombok.*;

@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class CatFilter {
    private String age;
    private Integer minAge;
    private Integer maxAge;
    private String weight;
    private Integer minWeight;
    private Integer maxWeight;
    private GenderEnum gender;
    private RegionEnum region;
    private CharacterEnum character;
    private ActivityEnum activity;
    private String vaccinatedString;
    private Boolean vaccinatedBool;
    private String sterilizedString;
    private Boolean sterilizedBool;
    private String childFriendlyString;
    private Boolean childFriendlyBool;
}
