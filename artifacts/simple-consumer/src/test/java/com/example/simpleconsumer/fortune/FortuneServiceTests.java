package com.example.simpleconsumer.fortune;

import com.example.simpleconsumer.SimpleConsumerApplication;
import org.assertj.core.api.BDDAssertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.cloud.contract.stubrunner.spring.AutoConfigureStubRunner;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.web.client.RestTemplate;

@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = SimpleConsumerApplication.class, webEnvironment = SpringBootTest.WebEnvironment.NONE)
@AutoConfigureStubRunner
public class FortuneServiceTests {

    FortuneService fortuneService = new FortuneService(new RestTemplate());

    @Test
    void shouldSendRequestToFortune() {

        // Expects system property stubrunner.ids to be set with a single local stub.
        //    e.g. use mvn with:
        //   -Dstubrunner.ids=com.example:simple-producer:build-1:stubs:10000
        //   -Dstubrunner.stubs-mode=LOCAL

        fortuneService.setFortuneServiceURL("http://localhost:10000");
        // when
        String fortune = fortuneService.getFortune();
        // then
        BDDAssertions.then(fortune).isEqualTo("foo fortune");
    }

}
