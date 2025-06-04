package com.example.simpleproducer.fortune;

import io.restassured.module.mockmvc.RestAssuredMockMvc;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.BDDMockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@AutoConfigureMockMvc
public abstract class BaseClass {

    // Provide a mock for FortuneService - stub out Service so Controller
    // always returns a known value when invoked
    // Spring will autowire the Controller and swap in a stub for the Service
    @MockitoBean
    protected FortuneService fortuneService;

    @MockitoBean
    protected ValidationService validationService;

    // Let Spring auto‑configure a MockMvc that has all your @RestController
    // beans already wired
    @Autowired
    private MockMvc mockMvc;

    @BeforeEach
    public void setup() {
        // Define the stub behavior once for every generated test
        BDDMockito.given(fortuneService.getFortune())
                .willReturn("foo fortune");

        BDDMockito.given(validationService.generateTrackingId())
                .willReturn(String.valueOf(100000001L));

        // Point RestAssured at Spring’s MockMvc
        RestAssuredMockMvc.mockMvc(mockMvc);
    }

}
