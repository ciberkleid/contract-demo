package com.example.simpleproducer.fortune;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/applications")
class ValidationController {

    private final ValidationService validationService;

    public ValidationController(ValidationService validationService) {
        this.validationService = validationService;
    }

    @PostMapping("/{applicationId}/validation")
    public ResponseEntity<String> applyValidation(
            @PathVariable int applicationId,
            @RequestHeader(value = "X-SYF-Request-TrackingId", required = false) String trackingId,
            @RequestBody(required = false) JsonNode application
    ) {

        if (trackingId != null) {
            trackingId = validationService.generateTrackingId();
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("X-SYF-Request-TrackingId", trackingId);
        headers.add("applicationId", String.valueOf(applicationId));

        return new ResponseEntity<>("{}", headers, HttpStatus.OK);
    }

}

