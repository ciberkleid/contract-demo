package com.example.simpleproducer.fortune;

import io.restassured.module.mockmvc.RestAssuredMockMvc;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.MOCK)
@AutoConfigureMockMvc
public abstract class BaseClass {

    @Autowired
    private MockMvc mockMvc;

    @BeforeEach
    public void setup() {
        RestAssuredMockMvc.mockMvc(mockMvc);
    }

    /*
    What this does:
    @SpringBootTest + @AutoConfigureMockMvc
        – boots the full Spring context and registers a MockMvc bean with all your controllers.
    @Autowired MockMvc mockMvc;
        – pulls in that auto‑configured MockMvc.
    RestAssuredMockMvc.mockMvc(mockMvc);
        – gives RestAssured the MockMvc to drive; after that, every generated given()… call
        will “just work” without you ever naming a controller or service.
     */
}

