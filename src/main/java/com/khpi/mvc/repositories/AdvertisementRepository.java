package com.khpi.mvc.repositories;

import com.khpi.mvc.models.Advertisement;
import com.khpi.mvc.models.Cat;
import com.khpi.mvc.models.Image;
import com.khpi.mvc.models.User;
import com.khpi.mvc.models.filters.CatFilter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

@Repository
public interface AdvertisementRepository
        extends JpaRepository<Advertisement, Long> {

    Page<Advertisement> findAll(Pageable pageable);
    Advertisement findAdvertisementById(Long id);
    List<Advertisement> findAllByOrderById();
    Page<Advertisement> findAllByUserOrderByIdDesc(Pageable pageable, User user);

    @Query("SELECT a FROM Advertisement a " +
            "WHERE (:#{#catFilter.minAge} IS NULL OR a.cat.age >= :#{#catFilter.minAge}) " +
            "AND (:#{#catFilter.maxAge} IS NULL OR a.cat.age <= :#{#catFilter.maxAge}) " +
            "AND (:#{#catFilter.minWeight} IS NULL OR a.cat.weight >= :#{#catFilter.minWeight}) " +
            "AND (:#{#catFilter.maxWeight} IS NULL OR a.cat.weight <= :#{#catFilter.maxWeight}) " +
            "AND (:#{#catFilter.gender} IS NULL OR a.cat.gender = :#{#catFilter.gender}) " +
            "AND (:#{#catFilter.region} IS NULL OR a.cat.region = :#{#catFilter.region}) " +
            "AND (:#{#catFilter.character} IS NULL OR a.cat.character = :#{#catFilter.character}) " +
            "AND (:#{#catFilter.activity} IS NULL OR a.cat.activity = :#{#catFilter.activity}) " +
            "AND (:#{#catFilter.vaccinatedBool} IS NULL OR a.cat.vaccinated = :#{#catFilter.vaccinatedBool}) " +
            "AND (:#{#catFilter.sterilizedBool} IS NULL OR a.cat.sterilized = :#{#catFilter.sterilizedBool}) " +
            "AND (:#{#catFilter.childFriendlyBool} IS NULL OR a.cat.childFriendly = :#{#catFilter.childFriendlyBool}) ")
    Page<Advertisement> findAllByCat(@Param("catFilter") CatFilter catFilter, Pageable pageable);
    @Query("SELECT a FROM Advertisement a " +
                  "WHERE (:#{#catFilter.minAge} IS NULL OR a.cat.age >= :#{#catFilter.minAge}) " +
                  "AND (:#{#catFilter.maxAge} IS NULL OR a.cat.age <= :#{#catFilter.maxAge}) " +
                  "AND (:#{#catFilter.minWeight} IS NULL OR a.cat.weight >= :#{#catFilter.minWeight}) " +
                  "AND (:#{#catFilter.maxWeight} IS NULL OR a.cat.weight <= :#{#catFilter.maxWeight}) " +
                  "AND (:#{#catFilter.gender} IS NULL OR a.cat.gender = :#{#catFilter.gender}) " +
                  "AND (:#{#catFilter.region} IS NULL OR a.cat.region = :#{#catFilter.region}) " +
                  "AND (:#{#catFilter.character} IS NULL OR a.cat.character = :#{#catFilter.character}) " +
                  "AND (:#{#catFilter.activity} IS NULL OR a.cat.activity = :#{#catFilter.activity}) " +
                  "AND (:#{#catFilter.vaccinatedBool} IS NULL OR a.cat.vaccinated = :#{#catFilter.vaccinatedBool}) " +
                  "AND (:#{#catFilter.sterilizedBool} IS NULL OR a.cat.sterilized = :#{#catFilter.sterilizedBool}) " +
                  "AND (:#{#catFilter.childFriendlyBool} IS NULL OR a.cat.childFriendly = :#{#catFilter.childFriendlyBool}) ")
    List<Advertisement> findAllByCatList(@Param("catFilter") CatFilter catFilter);
    @Query("SELECT a FROM Advertisement a " +
            "WHERE (:#{#catFilter.minAge} IS NULL OR a.cat.age >= :#{#catFilter.minAge}) " +
            "AND (:#{#catFilter.maxAge} IS NULL OR a.cat.age <= :#{#catFilter.maxAge}) " +
            "AND (:#{#catFilter.minWeight} IS NULL OR a.cat.weight >= :#{#catFilter.minWeight}) " +
            "AND (:#{#catFilter.maxWeight} IS NULL OR a.cat.weight <= :#{#catFilter.maxWeight}) " +
            "AND (:#{#catFilter.gender} IS NULL OR a.cat.gender = :#{#catFilter.gender}) " +
            "AND (:#{#catFilter.region} IS NULL OR a.cat.region = :#{#catFilter.region}) " +
            "AND (:#{#catFilter.character} IS NULL OR a.cat.character = :#{#catFilter.character}) " +
            "AND (:#{#catFilter.activity} IS NULL OR a.cat.activity = :#{#catFilter.activity}) " +
            "AND (:#{#catFilter.vaccinatedBool} IS NULL OR a.cat.vaccinated = :#{#catFilter.vaccinatedBool}) " +
            "AND (:#{#catFilter.sterilizedBool} IS NULL OR a.cat.sterilized = :#{#catFilter.sterilizedBool}) " +
            "AND (:#{#catFilter.childFriendlyBool} IS NULL OR a.cat.childFriendly = :#{#catFilter.childFriendlyBool}) " +
            "ORDER BY a.id DESC")
    Page<Advertisement> findAllByCatMostRecently(@Param("catFilter") CatFilter catFilter, Pageable pageable);
}
