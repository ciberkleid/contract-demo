package com.example.simpleproducer.fortune;

import io.restassured.module.mockmvc.RestAssuredMockMvc;
import org.junit.Before;
import org.mockito.BDDMockito;

public class BaseClass {

    @Before
    public void setup() {
        FortuneService service = BDDMockito.mock(FortuneService.class);
        BDDMockito.given(service.getFortune()).willReturn("foo fortune");
        RestAssuredMockMvc.standaloneSetup(new FortuneController(service));
    }
}
