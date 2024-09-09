package com.khpi.mvc.controllers;

import com.khpi.mvc.models.*;
import com.khpi.mvc.models.enums.ActivityEnum;
import com.khpi.mvc.models.enums.CharacterEnum;
import com.khpi.mvc.models.enums.GenderEnum;
import com.khpi.mvc.models.enums.RegionEnum;
import com.khpi.mvc.models.filters.CatFilter;
import com.khpi.mvc.service.AdvertisementService;
import com.khpi.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.yaml.snakeyaml.util.ArrayUtils;


import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Controller
public class AdvertisementController {
    private final AdvertisementService advertisementService;
    @Autowired
    public AdvertisementController(AdvertisementService advertisementService) {
        this.advertisementService = advertisementService;
    }
    @Autowired
    private UserService userService;
    @GetMapping("/adverts")
    public String getAllAdverts(@RequestParam(defaultValue = "0") int page,
                                Model model) {
        Page<Advertisement> advertisementPage = advertisementService.getAllAdvertisements(PageRequest.of(page, 15));
        List<Advertisement> advertisements = advertisementPage.getContent();
        List<Image> coverImages = advertisementService.getCoverImageForAdvertisements(advertisements);
        //model.addAttribute("catFilter", new CatFilter()); //Возможно нужно будет добавить для коректной фильтрации
        model.addAttribute("coverImages", coverImages);
        model.addAttribute("advertisements", advertisementPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", advertisementPage.getTotalPages());


        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null && !(authentication instanceof AnonymousAuthenticationToken);
        model.addAttribute("isAuthenticated", isAuthenticated);
        return "catalog";
    }
    @GetMapping("/adverts/filteredAdverts")
    public String getFilteredAdverts(@RequestParam(defaultValue = "0") int page,
                                     @RequestParam("regionLocation") String regionLocation,
                                     @RequestParam(name = "age", required = false) String age,
                                     @RequestParam(name = "weight", required = false) String weight,
                                     @RequestParam(name = "gender", required = false) String gender,
                                     @RequestParam(name = "character", required = false) String character,
                                     @RequestParam(name = "activity", required = false) String activity,
                                     @RequestParam(name = "sterilized", required = false) String sterilized,
                                     @RequestParam(name = "vaccinated", required = false) String vaccinated,
                                     @RequestParam(name = "childFriendly", required = false) String childFriendly,
                                     @RequestParam("submit") String submitAction,
                                     @RequestParam("sortType") String sortType,
                                     Model model) {
        CatFilter catFilter = new CatFilter();
        catFilter.setRegion(RegionEnum.valueOf(regionLocation));
        catFilter.setAge(age);
        catFilter.setWeight(weight);
        catFilter.setGender(GenderEnum.valueOf(gender));
        catFilter.setCharacter(CharacterEnum.valueOf(character));
        catFilter.setActivity(ActivityEnum.valueOf(activity));
        catFilter.setSterilizedString(sterilized);
        catFilter.setVaccinatedString(vaccinated);
        catFilter.setChildFriendlyString(childFriendly);
        switch (submitAction) {
            case "getAll":
                Page<Advertisement> advertisementPage;
                switch (sortType){
                    case "default", "oldest":
                        advertisementPage = advertisementService.getFilteredAdvertisements(catFilter, PageRequest.of(page, 15));
                        break;
                    default: //mostRecent
                        advertisementPage = advertisementService.getFilteredAdvertisementsMostRecently(catFilter, PageRequest.of(page, 15));
                        break;
                }
                List<Advertisement> advertisements = advertisementPage.getContent();
                List<Image> coverImages = advertisementService.getCoverImageForAdvertisements(advertisements);
                //model.addAttribute("catFilter", new CatFilter()); //Возможно нужно будет добавить для коректной фильтрации
                model.addAttribute("coverImages", coverImages);
                model.addAttribute("advertisements", advertisementPage.getContent());
                model.addAttribute("currentPage", advertisementPage.getNumber());
                model.addAttribute("totalPages", advertisementPage.getTotalPages());
                break;
            case "getRandom":
                Advertisement randomAdvertisement = advertisementService.getRandomAdvertisement(catFilter);
                List<Advertisement> randomAdvertisementList = new ArrayList<Advertisement>();
                randomAdvertisementList.add(randomAdvertisement);
                List<Image> coverImageForRandomAdvertisement = advertisementService.getCoverImageForAdvertisements(randomAdvertisementList);
                model.addAttribute("coverImages", coverImageForRandomAdvertisement);
                model.addAttribute("advertisements", randomAdvertisementList);
                break;
        }
        if(!regionLocation.isEmpty()){
        model.addAttribute("selectedRegion", regionLocation);
        }
        if(!age.isEmpty()) {
            model.addAttribute("selectedAge", age);
        }
        if(!weight.isEmpty()) {
            model.addAttribute("selectedWeight", weight);
        }
        if(!gender.isEmpty()) {
            model.addAttribute("selectedGender", gender);
        }
        if(!character.isEmpty()) {
            model.addAttribute("selectedCharacter", character);
        }
        if(!activity.isEmpty()) {
            model.addAttribute("selectedActivity", activity);
        }
        if(!sterilized.isEmpty()) {
            model.addAttribute("selectedSterilized", sterilized);
        }
        if(!vaccinated.isEmpty()) {
            model.addAttribute("selectedVaccinated", vaccinated);
        }
        if(!childFriendly.isEmpty()) {
            model.addAttribute("selectedChildFriendly", childFriendly);
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null && !(authentication instanceof AnonymousAuthenticationToken);
        model.addAttribute("isAuthenticated", isAuthenticated);
        return "catalog"; // Шаблон страницы с отфильтрованными объявлениями
    }
    @GetMapping("/user/myAdverts")
    public String getUserAdverts(@RequestParam(defaultValue = "0") int page,
                                 Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            User currentUser = userService.findUserByEmail(userDetails.getUsername());
            Page<Advertisement> usersAdvertisementsPage = advertisementService.getAllUsersAdverts(currentUser, PageRequest.of(page, 15));
            List<Advertisement> usersAdvertisements = usersAdvertisementsPage.getContent();
            List<Image> coverImages = advertisementService.getCoverImageForAdvertisements(usersAdvertisements);
            model.addAttribute("coverImages", coverImages);
            model.addAttribute("advertisements", usersAdvertisements);
            model.addAttribute("currentPage", usersAdvertisementsPage.getNumber());
            model.addAttribute("totalPages", usersAdvertisementsPage.getTotalPages());
            model.addAttribute("isAuthenticated", true);
        }
        return "myAdverts"; //"myAdverts"
    }
    @DeleteMapping("/user/myAdverts/delete/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteAd(@PathVariable("id") Long id) {
        try {
            advertisementService.deleteById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Ошибка при удалении объявления");
        }
    }
    @GetMapping("/user/myAdverts/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Advertisement advertisement = advertisementService.findById(id);
        model.addAttribute("advert", advertisement);
        model.addAttribute("isAuthenticated", true);
        return "editAdvertForm";
    }
    @PostMapping("/user/myAdverts/edit/{id}")
    public String editAdvert(@PathVariable("id") Long id,
                             @RequestParam("details") String details,
                             @ModelAttribute Cat cat,
                             Model model){
        Advertisement advertisementToEdit = advertisementService.findById(id);
        advertisementToEdit.setDetails(details);
        cat.setAdvertisement(advertisementToEdit);
        advertisementToEdit.setCat(cat);
        advertisementService.saveEditedAdvert(advertisementToEdit);
        return "redirect:/user/myAdverts";
    }
    @GetMapping("/adverts/advert/{id}")
    public String redirectToOrShowAdvertPage(@PathVariable Long id, RedirectAttributes attributes, Model model) {
        Advertisement advert = advertisementService.getAdvertisementById(id);
        if (advert == null) {
            // Обработка случая, когда объявление не найдено
            return "redirect:/adverts";
        }
        model.addAttribute("advert", advert);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null && !(authentication instanceof AnonymousAuthenticationToken);
        model.addAttribute("isAuthenticated", isAuthenticated);

        // Если запрос пришел на редирект, добавляем URL в атрибуты редиректа
        if (attributes.getAttribute("advertUrl") != null) {
            attributes.addAttribute("advertUrl", "/advert/" + id);
            return "redirect:/advertPage/{id}";
        }
        return "advert";
    }
    @GetMapping("/user/changeContactInfo")
    public String changeContactInfoForm(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String username = userDetails.getUsername();
        User currentUser = userService.findUserByEmail(username);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("isAuthenticated", true);
        return "changeContactsForm";
    }
    @PostMapping("/user/changeContactInfo")
    public String changeContactInfo(@RequestParam(name = "phoneNumber", required = false) String phoneNumber,
                                    @RequestParam(name = "telegramUsername", required = false) String telegramUsername,
                                    Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String username = userDetails.getUsername();
        User currentUser = userService.findUserByEmail(username);
        ContactInfo contactInfo = currentUser.getContactInfo();
        if (!phoneNumber.isEmpty()){
            contactInfo.setPhoneNumber(phoneNumber);
        }
        if (!telegramUsername.isEmpty()){
            contactInfo.setTelegramUsername(telegramUsername);
        }
        //setContactInfo
        userService.save(currentUser);
        return "redirect:/adverts";
    }
    @GetMapping("/user/add")
    public String addForm(RedirectAttributes redirectAttributes,
                          Model model) throws IOException {
        model.addAttribute("cat", new Cat());
        model.addAttribute("images", new ArrayList<MultipartFile>());
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String username = userDetails.getUsername();
        User currentUser = userService.findUserByEmail(username);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("isAuthenticated", true);
        return "addCatForm";
    }
    @PostMapping("/user/add")
    public String addAdvertisement(@RequestParam("images") ArrayList<MultipartFile> images,
                                   @RequestParam("details") String details,
                                   @ModelAttribute Cat cat,
                                   RedirectAttributes redirectAttributes,
                                   Model model) throws IOException {
        Advertisement advertisement = new Advertisement();
        cat.setAdvertisement(advertisement);
        advertisement.setCat(cat);
        advertisement.setDetails(details);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String username = userDetails.getUsername();
        User currentUser = userService.findUserByEmail(username);
        advertisement.setUser(currentUser);

        LocalDate todayDate = LocalDate.now();
        advertisement.setCreationDate(todayDate);

        /*List<Advertisement> advertisementsList = new ArrayList<>();
        advertisementsList.add(advertisement);
        currentUser.setAdvertisements(advertisementsList);*/


        // Вызов сервисного метода для сохранения объявления и изображений
        advertisementService.addAdvertisement(advertisement, images);
        redirectAttributes.addFlashAttribute("successMessage", "Оголошення успішно створено");

        boolean isAuthenticated = !(authentication instanceof AnonymousAuthenticationToken);
        model.addAttribute("isAuthenticated", isAuthenticated);

        return "redirect:/adverts"; // Перенаправление на страницу с объявлениями
    }
}
