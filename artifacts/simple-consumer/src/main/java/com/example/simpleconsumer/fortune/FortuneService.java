package com.example.simpleconsumer.fortune;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class FortuneService {

    private final RestTemplate restTemplate;

    @Value("${fortuneServiceURL:http://localhost:8081}")
    String fortuneServiceURL;

    public FortuneService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public String getFortune() {
        String fortune = restTemplate.getForObject(fortuneServiceURL, String.class);
        return fortune;
    }

    // for tests
    void setFortuneServiceURL(String url) {
        this.fortuneServiceURL = url;
    }

}
