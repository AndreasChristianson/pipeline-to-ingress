package com.pessimisitic.it.pipeline_to_ingress.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.Instant;

@org.springframework.stereotype.Controller
public class Controller {
    @RequestMapping(value = "/")
    public String home(
            Model model,
            @RequestHeader("Host") String hostHeader
    ) throws UnknownHostException {
        model.addAttribute("now", Instant.now().toString());
        model.addAttribute("hostName", InetAddress.getLocalHost().getHostName());
        model.addAttribute("hostHeader", hostHeader);

        return "index.html";
    }
}
