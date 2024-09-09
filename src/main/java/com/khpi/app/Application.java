package com.khpi.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;


@SpringBootApplication
@ComponentScan(basePackages = "com.khpi.mvc")
//@EnableJpaRepositories(basePackages = "com.khpi.mvc.repositories")
@EntityScan(basePackages = "com.khpi.mvc.models")
public class Application
{
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}