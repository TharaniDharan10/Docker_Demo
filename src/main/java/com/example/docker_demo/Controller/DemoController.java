package com.example.docker_demo.Controller;

import com.example.docker_demo.model.DataRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @GetMapping("/hello")
    public String helloWorld() {
        return "Hello World";
    }

    @GetMapping("/lovely")
    public String lovely() {
        return "I love you SweetHeart";
    }

    @GetMapping("hi")
    public String hi() {
        return "Hi";
    }

    @PostMapping("/submit")
    public String submitData(@RequestBody DataRequest request) {
        return "Received: " + request.getData();
    }
}

