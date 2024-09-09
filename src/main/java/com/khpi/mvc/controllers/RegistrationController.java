package com.khpi.mvc.controllers;

import com.khpi.mvc.models.User;
import com.khpi.mvc.service.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
public class RegistrationController {

    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@ModelAttribute("userForm") @Valid User userForm,
                          @RequestParam("telegramUsername") String telegramUsername,
                          @RequestParam("phoneNumber") String phoneNumber,
                          BindingResult bindingResult, Model model) {

        model.addAttribute("userForm", userForm);
        model.addAttribute("telegramUsername", telegramUsername);
        model.addAttribute("phoneNumber", phoneNumber);
        if (bindingResult.hasErrors()) {
            return "registration";
        }
        if (!userForm.getPassword().equals(userForm.getPasswordConfirm())){
            model.addAttribute("error", "Пароли не совпадают");
            return "registration";
        }
        if (!userService.saveUser(userForm, telegramUsername, phoneNumber)){
            model.addAttribute("error", "Користувач з таким email вже існує");
            return "registration";
        }
        return "redirect:/login";
    }
}
