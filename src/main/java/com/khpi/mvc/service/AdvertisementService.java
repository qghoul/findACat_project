package com.khpi.mvc.service;

import com.khpi.mvc.models.Advertisement;
import com.khpi.mvc.models.Image;
import com.khpi.mvc.models.User;
import com.khpi.mvc.models.enums.*;
import com.khpi.mvc.models.filters.CatFilter;
import com.khpi.mvc.repositories.AdvertisementRepository;
import com.khpi.mvc.repositories.ImageRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

@Service
public class AdvertisementService {
    @Autowired
    AdvertisementRepository advertisementRepository;
    @Autowired
    ImageRepository imageRepository;
    @Value("${image.upload.dir}")
    private String uploadDir;
    public Advertisement getAdvertisementById(long id) {
         return advertisementRepository.findAdvertisementById(id);
    }
    public List<Advertisement> getAllAdvertisementsOrderById() {
        return advertisementRepository.findAllByOrderById();
    }
    public boolean deleteById(Long id) {
        Advertisement advertisementToDelete = advertisementRepository.findAdvertisementById(id);
        advertisementRepository.delete(advertisementToDelete);
        return true;
    }
    public void saveEditedAdvert(Advertisement advertisement){advertisementRepository.save(advertisement);}
    public Advertisement findById(Long id){
        return advertisementRepository.findAdvertisementById(id);
    }
    public Page<Advertisement> getAllUsersAdverts(User user, Pageable pageable){
        return advertisementRepository.findAllByUserOrderByIdDesc(pageable, user);
    }
    public Page<Advertisement> getAllAdvertisements(Pageable pageable) {
        return advertisementRepository.findAll(pageable);
    }
    public Page<Advertisement> getFilteredAdvertisements(CatFilter catFilter, Pageable pageable) {
        // DONE ! Нужно обработать все значения из catFilter, и параметрам со значением any
        // присвоить значение null для корректной обработки в AdvertisementRepository

        CatFilter convertedCatFilter = convertParams(catFilter); // !!!
        return advertisementRepository.findAllByCat(convertedCatFilter, pageable);
    }
    public Page<Advertisement> getFilteredAdvertisementsMostRecently(CatFilter catFilter, Pageable pageable) {
        CatFilter convertedCatFilter = convertParams(catFilter); // !!!
        return advertisementRepository.findAllByCatMostRecently(convertedCatFilter, pageable);
    }
    public Advertisement getRandomAdvertisement(CatFilter catFilter) {
        CatFilter convertedCatFilter = convertParams(catFilter);
        List<Advertisement> advertisements = advertisementRepository.findAllByCatList(convertedCatFilter);

        if (advertisements.isEmpty()) {
            return null; // или выбросьте исключение, если нужно
        }

        Random random = new Random();
        int randomIndex = random.nextInt(advertisements.size());
        return advertisements.get(randomIndex);
    }
    private CatFilter convertParams(CatFilter catFilter) {
        switch (catFilter.getGender()){
            case male, female:
                break;
            case any:
                catFilter.setGender(null);
                break;
        }
        switch (catFilter.getActivity()){
            case calm, active:
                break;
            case any:
                catFilter.setActivity(null);
                break;
        }
        switch (catFilter.getCharacter()){
            case sociable, independent:
                break;
            case any:
                catFilter.setCharacter(null);
                break;
        }
        switch (catFilter.getSterilizedString()){
            case "yes":
                catFilter.setSterilizedBool(true);
                break;
            case "no":
                catFilter.setSterilizedBool(false);
                break;
            case "any":
                catFilter.setSterilizedBool(null);
                break;
        }
        switch (catFilter.getVaccinatedString()){
            case "yes":
                catFilter.setVaccinatedBool(true);
                break;
            case "no":
                catFilter.setVaccinatedBool(false);
                break;
            case "any":
                catFilter.setVaccinatedBool(null);
                break;
        }
        switch (catFilter.getChildFriendlyString()){
            case "yes":
                catFilter.setChildFriendlyBool(true);
                break;
            case "any":
                catFilter.setChildFriendlyBool(null);
                break;
        }
        switch (catFilter.getAge()) {
            case "young":
                catFilter.setMinAge(null);
                catFilter.setMaxAge(1);
                break;
            case "middle":
                catFilter.setMinAge(2);
                catFilter.setMaxAge(6);
                break;
            case "old":
                catFilter.setMinAge(7);
                catFilter.setMaxAge(null); // Не ограничиваем верхний предел для "7+"
                break;
            default:
                // Ничего не делаем для значения "default" или других значений
                break;
        }

        switch (catFilter.getWeight()) {
            case "small":
                catFilter.setMinWeight(null);
                catFilter.setMaxWeight(2);
                break;
            case "medium":
                catFilter.setMinWeight(2);
                catFilter.setMaxWeight(5);
                break;
            case "big":
                catFilter.setMinWeight(5);
                catFilter.setMaxWeight(null); // Не ограничиваем верхний предел для "5+"
                break;
            default:
                // Ничего не делаем для значения "default" или других значений
                break;
        }
        return catFilter;
    }
    public List<Image> getCoverImageForAdvertisements(List<Advertisement> advertisements) {
        List<Image> coverImages = new ArrayList<>();
        for (Advertisement advert : advertisements) {
            Image coverImage = imageRepository.findFirstByAdvertisementIdAndIsCoverImageTrue(advert.getId());
            if (coverImage != null) {
                coverImages.add(coverImage);
            } else {

            }
        }
        return coverImages;
    }
    //public Image getCoverImageForAdvertisement
    @Transactional
    public Advertisement addAdvertisement(Advertisement advertisement, ArrayList<MultipartFile> imageFiles)
            throws IOException {
        Advertisement savedAdvertisement = advertisementRepository.save(advertisement);
        short imageCount = 0;
        for(MultipartFile file : imageFiles) {
            String uniqueFileName = UUID.randomUUID().toString().substring(0, 8) + "_" + file.getOriginalFilename();
            Image image = new Image();
            image.setAdvertisement(savedAdvertisement);
            String filePath = Paths.get(uploadDir, uniqueFileName).toString();
            image.setName(uniqueFileName);

            File destFile = new File(filePath);
            file.transferTo(destFile);
            imageRepository.save(image);
            if(imageCount == 0) {
                image.setIsCoverImage(true);
            }
            imageCount++;
        }
        return advertisementRepository.save(savedAdvertisement);
    }
}
