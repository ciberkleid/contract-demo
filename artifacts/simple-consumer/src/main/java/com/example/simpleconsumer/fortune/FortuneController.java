package com.example.simpleconsumer.fortune;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FortuneController {

    private final FortuneService fortuneService;

    public FortuneController(FortuneService fortuneService) {
        this.fortuneService = fortuneService;
    }

    @RequestMapping("/")
    String getFortune() {
        String fortune = fortuneService.getFortune();
        return "The fortune-teller says: ".concat(fortune);
    }


}
