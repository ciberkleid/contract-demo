package com.example.simpleproducer.fortune;

import io.restassured.module.mockmvc.RestAssuredMockMvc;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.BDDMockito;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public abstract class BaseClass {

    @Mock
    protected FortuneService service;

    @BeforeEach
    public void setup() {
        BDDMockito.given(service.getFortune()).willReturn("foo fortune");
        RestAssuredMockMvc.standaloneSetup(new FortuneController(service));
    }
}
