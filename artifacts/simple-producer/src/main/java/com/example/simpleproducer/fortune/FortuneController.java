package com.example.simpleproducer.fortune;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FortuneController {

    private final FortuneService fortuneService;

    public FortuneController(FortuneService fortuneService) {
        this.fortuneService = fortuneService;
    }

    @RequestMapping("/")
    String getFortune(){
        return fortuneService.getFortune();
    }

}
